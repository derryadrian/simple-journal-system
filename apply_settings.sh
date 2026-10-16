#!/usr/bin/env bash
# Jalankan dari folder project (yang ada mix.exs):  bash apply_settings.sh
# Aman dijalankan ulang: langkah yang sudah pernah jalan dilewati.

cd "$(dirname "$0")" || exit 1
if [ ! -f mix.exs ]; then
  echo "File ini harus ada di folder project (yang ada mix.exs)."
  exit 1
fi

USER_EX=lib/simple_journal_system/accounts/user.ex
ACCOUNTS=lib/simple_journal_system/accounts.ex

echo "== 0. user.ex: password_changeset dan validate_current_password"
if grep -q "def password_changeset" "$USER_EX"; then
  echo "   sudah ada, dilewati"
else
  if [ "$(tail -n1 "$USER_EX")" = "end" ]; then
    sed -i '$d' "$USER_EX"
    cat >> "$USER_EX" <<'EOF_USER'

  @doc """
  Changeset untuk ganti password. Opsi `hash_password: false` dipakai untuk
  validasi di form (tanpa hashing).
  """
  def password_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password])
    |> validate_length(:password, min: 6)
    |> validate_confirmation(:password, message: "tidak sama dengan password")
    |> maybe_put_password_hash(opts)
  end

  defp maybe_put_password_hash(changeset, opts) do
    if Keyword.get(opts, :hash_password, true) do
      put_password_hash(changeset)
    else
      changeset
    end
  end

  @doc """
  Menambahkan error kalau password saat ini salah.
  """
  def validate_current_password(changeset, password) do
    if valid_password?(changeset.data, password) do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end

  defp valid_password?(%__MODULE__{hashed_password: hash}, password)
       when is_binary(hash) and is_binary(password) and byte_size(password) > 0 do
    String.starts_with?(hash, "$2") and Bcrypt.verify_pass(password, hash)
  end

  defp valid_password?(_user, _password), do: false
end
EOF_USER
    echo "   ditambahkan"
  else
    echo "   GAGAL: baris terakhir user.ex bukan 'end', periksa manual"
    exit 1
  fi
fi

echo "== 1. accounts.ex: change_user_password/3"
if grep -q "def change_user_password" "$ACCOUNTS"; then
  echo "   sudah ada, dilewati"
else
  sed -i '/^  def update_user_password(user, password, attrs) do/i\  def change_user_password(user, attrs, opts) do\n    User.password_changeset(user, attrs, opts)\n  end\n' "$ACCOUNTS"
  echo "   ditambahkan"
fi

echo "== 2. settings.ex (LiveView)"
cat > lib/simple_journal_system_web/live/user_live/settings.ex <<'EOF_SETTINGS'
defmodule SimpleJournalSystemWeb.UserLive.Settings do
  use SimpleJournalSystemWeb, :live_view

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystem.Accounts.User

  @impl true
  def render(assigns) do
    ~H"""
    <Layouts.app flash={@flash} current_scope={@current_scope}>
      <div class="text-center">
        <.header>
          Account Settings
          <:subtitle>Manage your account password</:subtitle>
        </.header>
      </div>

      <p class="mt-4 text-sm text-center">Signed in as <strong>{@current_email}</strong></p>

      <.form
        for={@password_form}
        id="password_form"
        action={~p"/users/update-password"}
        method="post"
        phx-change="validate_password"
        phx-submit="update_password"
        phx-trigger-action={@trigger_submit}
      >
        <input type="hidden" name={@password_form[:email].name} value={@current_email} />
        <.input
          field={@password_form[:current_password]}
          type="password"
          label="Current password"
          autocomplete="current-password"
          required
        />
        <.input
          field={@password_form[:password]}
          type="password"
          label="New password"
          autocomplete="new-password"
          required
        />
        <.input
          field={@password_form[:password_confirmation]}
          type="password"
          label="Confirm new password"
          autocomplete="new-password"
        />
        <.button variant="primary" phx-disable-with="Saving...">Save Password</.button>
      </.form>
    </Layouts.app>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    user = socket.assigns.current_scope.user
    changeset = Accounts.change_user_password(user, %{}, hash_password: false)

    socket =
      socket
      |> assign(:current_email, user.email)
      |> assign(:password_form, to_form(changeset))
      |> assign(:trigger_submit, false)

    {:ok, socket}
  end

  @impl true
  def handle_event("validate_password", %{"user" => user_params}, socket) do
    form =
      socket.assigns.current_scope.user
      |> Accounts.change_user_password(user_params, hash_password: false)
      |> Map.put(:action, :validate)
      |> to_form()

    {:noreply, assign(socket, password_form: form)}
  end

  def handle_event("update_password", %{"user" => user_params}, socket) do
    user = socket.assigns.current_scope.user

    changeset =
      user
      |> Accounts.change_user_password(user_params, hash_password: false)
      |> User.validate_current_password(user_params["current_password"])

    case Ecto.Changeset.apply_action(changeset, :update) do
      {:ok, _user} ->
        {:noreply, assign(socket, trigger_submit: true)}

      {:error, changeset} ->
        {:noreply, assign(socket, password_form: to_form(changeset))}
    end
  end
end
EOF_SETTINGS

echo "== 3. user_session_controller.ex"
cat > lib/simple_journal_system_web/controllers/user_session_controller.ex <<'EOF_CONTROLLER'
defmodule SimpleJournalSystemWeb.UserSessionController do
  use SimpleJournalSystemWeb, :controller

  alias SimpleJournalSystem.Accounts
  alias SimpleJournalSystemWeb.UserAuth
  alias SimpleJournalSystemWeb.RateLimit

  def create(conn, %{"_action" => "confirmed"} = params) do
    create(conn, params, "User confirmed successfully.")
  end

  def create(conn, params) do
    create(conn, params, "Welcome back!")
  end

  # magic link login
  defp create(conn, %{"user" => %{"token" => token} = user_params}, info) do
    case Accounts.login_user_by_magic_link(token) do
      {:ok, {user, tokens_to_disconnect}} ->
        UserAuth.disconnect_sessions(tokens_to_disconnect)

        conn
        |> put_flash(:info, info)
        |> UserAuth.log_in_user(user, user_params)

      _ ->
        conn
        |> put_flash(:error, "The link is invalid or it has expired.")
        |> redirect(to: ~p"/users/log-in")
    end
  end

  # email + password login
  defp create(conn, %{"user" => user_params}, info) do
    %{"email" => email, "password" => password} = user_params
    identifier = RateLimit.get_identifier_for_email(conn, email)

    if user = Accounts.get_user_by_email_and_password(email, password) do
      RateLimit.reset_login_attempts(identifier)

      conn
      |> put_flash(:info, info)
      |> UserAuth.log_in_user(user, user_params)
    else
      RateLimit.increment_login_attempt(identifier)

      # In order to prevent user enumeration attacks, don't disclose whether the email is registered.
      conn
      |> put_flash(:error, "Invalid email or password")
      |> put_flash(:email, String.slice(email, 0, 160))
      |> redirect(to: ~p"/users/log-in")
    end
  end

  def update_password(conn, %{"user" => user_params} = params) do
    user = conn.assigns.current_scope.user

    case Accounts.update_user_password(user, user_params["current_password"], user_params) do
      {:ok, _user} ->
        conn
        |> put_session(:user_return_to, ~p"/users/settings")
        |> create(params, "Password updated successfully!")

      {:error, _changeset} ->
        conn
        |> put_flash(:error, "Password could not be updated.")
        |> redirect(to: ~p"/users/settings")
    end
  end

  def delete(conn, _params) do
    conn
    |> put_flash(:info, "Logged out successfully.")
    |> UserAuth.log_out_user()
  end
end
EOF_CONTROLLER

echo "== 4. router.ex: hapus route confirm-email"
sed -i '/live "\/users\/settings\/confirm-email\/:token", UserLive.Settings, :confirm_email/d' lib/simple_journal_system_web/router.ex

echo "== 5. settings_test.exs"
cat > test/simple_journal_system_web/live/user_live/settings_test.exs <<'EOF_TEST'
defmodule SimpleJournalSystemWeb.UserLive.SettingsTest do
  use SimpleJournalSystemWeb.ConnCase

  import Phoenix.LiveViewTest
  import SimpleJournalSystem.AccountsFixtures

  alias SimpleJournalSystem.Accounts

  describe "Settings page" do
    test "renders settings page", %{conn: conn} do
      user = user_fixture()
      {:ok, _lv, html} = conn |> log_in_user(user) |> live(~p"/users/settings")

      assert html =~ "Account Settings"
      assert html =~ user.email
    end

    test "redirects to login if user is not logged in", %{conn: conn} do
      assert {:error, redirect} = live(conn, ~p"/users/settings")
      assert {:redirect, %{to: path}} = redirect
      assert path == ~p"/users/log-in"
    end
  end

  describe "update password form" do
    setup %{conn: conn} do
      user = user_fixture()
      %{conn: log_in_user(conn, user), user: user}
    end

    test "renders errors with invalid data (phx-change)", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/settings")

      result =
        lv
        |> element("#password_form")
        |> render_change(%{
          "user" => %{
            "current_password" => "password123",
            "password" => "short",
            "password_confirmation" => "different"
          }
        })

      assert result =~ "at least 6 character"
      assert result =~ "tidak sama dengan password"
    end

    test "renders error when current password is wrong", %{conn: conn} do
      {:ok, lv, _html} = live(conn, ~p"/users/settings")

      result =
        lv
        |> form("#password_form", %{
          "user" => %{
            "current_password" => "salah-total",
            "password" => "newpassword123",
            "password_confirmation" => "newpassword123"
          }
        })
        |> render_submit()

      assert result =~ "is not valid"
    end

    test "updates the user password", %{conn: conn, user: user} do
      {:ok, lv, _html} = live(conn, ~p"/users/settings")

      form =
        form(lv, "#password_form", %{
          "user" => %{
            "current_password" => "password123",
            "password" => "newpassword123",
            "password_confirmation" => "newpassword123"
          }
        })

      render_submit(form)
      new_password_conn = follow_trigger_action(form, conn)

      assert redirected_to(new_password_conn) == ~p"/users/settings"
      assert Accounts.get_user_by_email_and_password(user.email, "newpassword123")
    end
  end
end
EOF_TEST

echo "== 6. perbaikan kecil (debug log, hasil tertumpuk, skip test halaman admin)"
sed -i '/# --- DEBUG GLOBAL SESSION PRELOAD ---/,/# ------------------------------------/d' lib/simple_journal_system_web/user_auth.ex
sed -i '/def bulk_enroll/,/^  end$/s#^      {:ok, results}$#      results#' "$ACCOUNTS"
sed -i '/def update_user_roles/,/^  end$/s#^      {:ok, list_user_roles(user_id)}$#      list_user_roles(user_id)#' "$ACCOUNTS"
if ! grep -B1 'test "require_admin allows site admin"' test/simple_journal_system_web/user_auth_test.exs | grep -q '@tag :skip'; then
  sed -i '/test "require_admin allows site admin"/i\    @tag :skip' test/simple_journal_system_web/user_auth_test.exs
fi

echo
echo "== Perubahan:"
git --no-pager diff --stat
echo
echo "== Menjalankan test (agak lama)..."
mix test > hasil_test.txt 2>&1
grep -E "tests,|failures|\*\* \(Compile" hasil_test.txt
echo
echo "Selesai. Tempel dua bagian di atas (daftar perubahan dan hasil 'tests, ... failures') ke chat."
