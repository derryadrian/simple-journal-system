defmodule SimpleJournalSystem.Accounts do
  import Ecto.Query

  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserToken
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserUserGroup

  @sudo_mode_validity_in_minutes 20

  ## =========================
  ## Database getters
  ## =========================

  def list_user_groups(%User{user_id: user_id}) do
    UserUserGroup
    |> where(user_id: ^user_id)
    |> join(:inner, [uug], ug in UserGroup, on: uug.user_group_id == ug.user_group_id)
    |> select([_uug, ug], ug)
    |> Repo.all()
  end

  def get_user_by_email(email) do
    get_user_by_email_or_username(email)
  end

  def get_user!(user_id) do
    Repo.get!(User, user_id)
  end

  defp get_user_by_email_or_username(login) do
    from(u in User,
      where: u.email == ^login or u.username == ^login,
      limit: 1
    )
    |> Repo.one()
  end

  ## =========================
  ## Authentication
  ## =========================

  def get_user_by_email_and_password(email, password) do
    user = get_user_by_email_or_username(email)

    if user && Bcrypt.verify_pass(password, user.hashed_password) do
      user
    else
      nil
    end
  end

  ## =========================
  ## Magic link
  ## =========================

  def get_user_by_magic_link_token(token) do
    with {:ok, query} <- UserToken.verify_magic_link_token_query(token),
         {user, _token} <- Repo.one(query) do
      Repo.preload(user, user_user_groups: :user_group)
    else
      _ -> nil
    end
  end

  def login_user_by_magic_link(token) do
    with {:ok, query} <- UserToken.verify_magic_link_token_query(token),
        {user, user_token} <- Repo.one(query) do
      user = Repo.preload(user, user_user_groups: :user_group)

      cond do
        # Case 1 — unconfirmed + password → raise
        is_nil(user.confirmed_at) && not is_nil(user.hashed_password) ->
          raise "magic link log in is not allowed when a password is set"

        # Case 2 — unconfirmed + no password → confirm
        is_nil(user.confirmed_at) ->
          now = NaiveDateTime.utc_now(:second)

          authenticated_user =
            user
            |> Ecto.Changeset.change(
              confirmed_at: now,
              authenticated_at: now
            )

          case Repo.update(authenticated_user) do
            {:ok, user} ->
              Repo.delete(user_token)
              {:ok, {user, [user_token]}}

            {:error, _changeset} ->
              :error
          end

        # Case 3 — confirmed → return []
        true ->
          Repo.delete(user_token)
          {:ok, {user, []}}
      end
    else
      nil -> {:error, :not_found}
      _ -> :error
    end
  end

  def get_user_by_session_token(token) do
    case UserToken.verify_session_token_query(token) do
      {:ok, query} ->
        case Repo.one(query) do
          {user, inserted_at} ->
            {
              Repo.preload(user, user_user_groups: :user_group),
              inserted_at
            }

          nil ->
            nil
        end

      :error ->
        nil
    end
  end

  def generate_user_session_token(%User{} = user) do
    {token, user_token} = UserToken.build_session_token(user)
    Repo.insert!(user_token)
    token
  end

  def delete_user_session_token(token) do
    Repo.delete_all(UserToken.by_token_and_context_query(token, "session"))
    :ok
  end

  ## =========================
  ## Sudo mode
  ## =========================

  def sudo_mode?(%User{authenticated_at: nil}) do
    false
  end

  def sudo_mode?(%User{authenticated_at: authenticated_at}) do
    DateTime.diff(
      DateTime.utc_now(:second),
      authenticated_at,
      :second
    ) <= @sudo_mode_validity_in_minutes * 60
  end

  def sudo_mode?(%User{}, _opts) do
    false
  end

  ## =========================
  ## Registration
  ## =========================

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def change_user_registration(%User{} = user, attrs \\ %{}) do
    User.registration_changeset(user, attrs)
  end

  ## =========================
  ## Email
  ## =========================

  def change_user_email(%User{} = user) do
    User.email_changeset(user, %{})
  end

  def change_user_email(%User{} = user, attrs) do
    User.email_changeset(user, attrs)
  end

  def change_user_email(%User{} = user, attrs, opts) do
    User.email_changeset(user, attrs, opts)
  end

  def apply_user_email(user, password, attrs) do
    user
    |> User.email_changeset(attrs)
    |> User.validate_current_password(password)
    |> Repo.update()
  end

  def deliver_user_update_email_instructions(
        %User{} = user,
        email,
        url_fun
      ) do
    {encoded_token, user_token} =
      UserToken.build_hashed_token_for_email_change(user, email)

    Repo.insert!(user_token)

    SimpleJournalSystem.Emails.deliver_update_email_instructions(
      user,
      email,
      encoded_token,
      url_fun
    )
  end

  ## =========================
  ## Password
  ## =========================

  def change_user_password(%User{} = user) do
    User.password_changeset(user, %{})
  end

  def change_user_password(%User{} = user, attrs) do
    User.password_changeset(user, attrs)
  end

  def change_user_password(%User{} = user, attrs, opts) do
    User.password_changeset(user, attrs, opts)
  end

  def update_user_password(user, attrs) do
    with {:ok, updated_user} <-
          user
          |> User.password_changeset(attrs)
          |> Repo.update() do
      expired_tokens =
        UserToken
        |> where(user_id: ^user.user_id, context: "session")
        |> Repo.all()

      Repo.delete_all(
        from(t in UserToken,
          where: t.user_id == ^user.user_id and t.context == "session"
        )
      )

      updated_user = %{updated_user | password: nil, password_confirmation: nil}

      {:ok, {updated_user, expired_tokens}}
    end
  end

  def update_user_password(user, password, attrs) do
    user
    |> User.password_changeset(attrs)
    |> User.validate_current_password(password)
    |> Repo.update()
  end

  ## =========================
  ## Confirmation
  ## =========================

  def deliver_user_confirmation_instructions(%User{} = user) do
    {encoded_token, user_token} =
      UserToken.build_email_token(user, "confirm")

    Repo.insert!(user_token)

    SimpleJournalSystem.Emails.deliver_confirmation_instructions(
      user,
      encoded_token
    )
  end

  def deliver_login_instructions(%User{} = user, url_fun) do
    {encoded_token, user_token} =
      UserToken.build_email_token(user, "login")

    Repo.insert!(user_token)

    SimpleJournalSystem.Emails.deliver_login_instructions(
      user,
      encoded_token,
      url_fun
    )
  end

  def confirm_user(token) do
    with {:ok, query} <-
           UserToken.verify_email_token_query(token, "confirm"),
         %User{} = user <- Repo.one(query),
         {:ok, %{}} <-
           User.confirm_changeset(user)
           |> Repo.update() do
      {:ok, user}
    else
      _ -> :error
    end
  end

  ## =========================
  ## Reset password
  ## =========================

  def deliver_user_reset_password_instructions(%User{} = user) do
    {encoded_token, user_token} =
      UserToken.build_email_token(user, "reset_password")

    Repo.insert!(user_token)

    SimpleJournalSystem.Emails.deliver_reset_password_instructions(
      user,
      encoded_token
    )
  end

  def reset_user_password(token, attrs) do
    with {:ok, query} <-
           UserToken.verify_email_token_query(token, "reset_password"),
         %User{} = user <- Repo.one(query),
         {:ok, %{}} <-
           User.password_changeset(user, attrs)
           |> Repo.update() do
      {:ok, user}
    else
      _ -> :error
    end
  end

  ## =========================
  ## Update email
  ## =========================

  def update_user_email(%User{} = user, token) do
    case Repo.transaction(fn ->
           with {:ok, query} <-
                  UserToken.verify_change_email_token_query(token, "change:"),
                {%UserToken{} = user_token, %User{} = token_user} <-
                  Repo.one(query),
                true <- token_user.user_id == user.user_id,
                true <- token_user.email == user.email,
                email <- token_context(user_token.context),
                changeset <-
                  User.email_changeset(user, %{email: email}),
                {:ok, updated_user} <- Repo.update(changeset) do
             Repo.delete(user_token)
             updated_user
           else
             _ -> Repo.rollback(:error)
           end
         end) do
      {:ok, updated_user} -> {:ok, updated_user}
      {:error, _} -> {:error, :transaction_aborted}
    end
  end

  defp token_context(token) do
    token
    |> String.split(":", parts: 2)
    |> List.last()
  end
end
