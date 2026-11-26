defmodule SimpleJournalSystem.Accounts do
  import Ecto.Query

  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserToken

  ## Database getters

  # Mendukung login menggunakan email ATAU username.
  # Pencarian dibuat case-insensitive.
  def get_user_by_email(email) do
    get_user_by_email_or_username(email)
  end

  defp get_user_by_email_or_username(login) when is_binary(login) do
    login = String.trim(login)

    query =
      from u in User,
        where:
          fragment("lower(?)", u.email) == ^String.downcase(login) or
            fragment("lower(?)", u.username) == ^String.downcase(login),
        limit: 1

    Repo.one(query)
  end

  defp get_user_by_email_or_username(_login), do: nil

  # Fungsi login utama.
  #
  # Aturan:
  # - email atau username boleh digunakan
  # - case-insensitive
  # - akun disabled tidak boleh login
  # - password harus valid
  # - date_last_login diperbarui jika login berhasil
  #
  # Semua kegagalan dikembalikan sebagai nil agar tidak membocorkan
  # apakah username/email tertentu terdaftar.
  def get_user_by_email_and_password(login, password) do
    user = get_user_by_email_or_username(login)

    cond do
      is_nil(user) ->
        nil

      user.disabled != 0 ->
        nil

      not Bcrypt.verify_pass(password, user.hashed_password) ->
        nil

      true ->
        update_last_login(user)
    end
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def sudo_mode?(user, ttl_in_minutes \\ 20) do
    authenticated_at = user.authenticated_at

    if is_nil(authenticated_at) do
      false
    else
      deadline = DateTime.add(DateTime.utc_now(), -ttl_in_minutes * 60, :second)
      DateTime.compare(authenticated_at, deadline) == :gt
    end
  end

  def get_user_by_magic_link_token(token) do
    with {:ok, query} <- UserToken.verify_magic_link_token_query(token),
         {%User{} = user, _token} <- Repo.one(query),
         true <- user.disabled == 0 do
      user
    else
      _ -> nil
    end
  end

  def login_user_by_magic_link(token) do
    with {:ok, query} <- UserToken.verify_magic_link_token_query(token),
         {%User{} = user, user_token} <- Repo.one(query),
         true <- user.disabled == 0 do
      {user, expired_tokens} =
        if is_nil(user.confirmed_at) do
          confirmed_user = User.confirm_changeset(user) |> Repo.update!()
          Repo.delete_all(UserToken.by_token_and_context_query(user_token.token, "login"))
          {confirmed_user, [%{token: user_token.token}]}
        else
          Repo.delete_all(UserToken.by_token_and_context_query(user_token.token, "login"))
          {user, []}
        end

      {:ok, {user, expired_tokens}}
    else
      _ -> {:error, :not_found}
    end
  end

  def change_user_password(user, attrs \\ %{}, opts \\ []) do
    User.password_changeset(user, attrs, opts)
  end

  def update_user_password(user, attrs) do
    changeset = change_user_password(user, attrs, hash_password: true)

    if changeset.valid? do
      expired_tokens =
        from(t in UserToken, where: t.user_id == ^user.user_id, select: %{token: t.token})
        |> Repo.all()

      Repo.delete_all(from(t in UserToken, where: t.user_id == ^user.user_id))

      user = Repo.update!(changeset)
      {:ok, {user, expired_tokens}}
    else
      {:error, changeset}
    end
  end

  defp update_last_login(%User{} = user) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    from(u in User, where: u.user_id == ^user.user_id)
    |> Repo.update_all(set: [date_last_login: now])

    %{user | date_last_login: now}
  end

  ## Session token

  def get_user_by_session_token(token) do
    {:ok, query} = UserToken.verify_session_token_query(token)
    Repo.one(query)
  end

  ## Session token management

  def generate_user_session_token(user) do
    {token, user_token} = UserToken.build_session_token(user)
    Repo.insert!(user_token)
    token
  end

  def delete_user_session_token(token) do
    Repo.delete_all(UserToken.by_token_and_context_query(token, "session"))
    :ok
  end

  ## Registration

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def change_user_registration(%User{} = user, attrs) do
    User.registration_changeset(user, attrs)
  end

  ## Email and password updates

  def change_user_email(user, attrs \\ %{}, opts \\ []) do
    User.email_changeset(user, attrs, opts)
  end

  def deliver_login_instructions(user, url) do
    {encoded_token, user_token} = UserToken.build_email_token(user, "login")

    Repo.insert!(user_token)

    SimpleJournalSystem.Accounts.UserNotifier.deliver_login_instructions(
      user,
      url.(encoded_token)
    )
  end

  def apply_user_email(user, password, attrs) do
    user
    |> User.email_changeset(attrs)
    |> User.validate_current_password(password)
    |> Repo.update()
  end

  def update_user_password(user, password, attrs) do
    user
    |> User.password_changeset(attrs)
    |> User.validate_current_password(password)
    |> Repo.update()
  end

  ## Confirmation

  def deliver_user_confirmation_instructions(%User{} = user) do
    {encoded_token, user_token} =
      UserToken.build_email_token(user, "confirm")

    Repo.insert!(user_token)

    SimpleJournalSystem.Accounts.UserNotifier.deliver_confirmation_instructions(
      user,
      encoded_token
    )
  end

  def confirm_user(token) do
    with {:ok, query} <- UserToken.verify_email_token_query(token, "confirm"),
         %User{} = user <- Repo.one(query),
         {:ok, %{}} <- User.confirm_changeset(user) |> Repo.update() do
      {:ok, user}
    else
      _ -> :error
    end
  end

  ## Reset password

  def deliver_user_reset_password_instructions(%User{} = user) do
    {encoded_token, user_token} =
      UserToken.build_email_token(user, "reset_password")

    Repo.insert!(user_token)

    url = "/users/reset_password/" <> encoded_token

    SimpleJournalSystem.Accounts.UserNotifier.deliver_reset_password_instructions(
      user,
      url
    )
  end

  def get_user_by_reset_password_token(token) do
    with {:ok, query} <- UserToken.verify_reset_password_token_query(token),
         {%User{} = user, _token} <- Repo.one(query) do
      user
    else
      _ -> nil
    end
  end

  def reset_user_password(token, attrs) do
    with {:ok, query} <- UserToken.verify_reset_password_token_query(token),
         {%User{} = user, user_token} <- Repo.one(query),
         {:ok, updated_user} <- User.password_changeset(user, attrs) |> Repo.update() do
      Repo.delete_all(UserToken.by_token_and_context_query(user_token.token, "reset_password"))
      {:ok, updated_user}
    else
      _ -> :error
    end
  end

  ## Update email dengan konfirmasi

  def deliver_user_update_email_instructions(%User{} = user, email) do
    {encoded_token, user_token} =
      UserToken.build_email_token(user, "change:#{email}")

    Repo.insert!(user_token)

    SimpleJournalSystem.Accounts.UserNotifier.deliver_update_email_instructions(
      user,
      encoded_token
    )
  end

  def deliver_user_update_email_instructions(user, email, url) do
    {encoded_token, user_token} =
      UserToken.build_email_token(user, "change:#{email}")

    Repo.insert!(user_token)

    SimpleJournalSystem.Accounts.UserNotifier.deliver_update_email_instructions(
      user,
      url.(encoded_token)
    )
  end

  def update_user_email(user, token) do
    Repo.transaction(fn ->
      with {:ok, query} <-
             UserToken.verify_change_email_token_query(token, "change:" <> user.email),
           %UserToken{} = user_token <- Repo.one(query),
           {:ok, updated_user} <-
             User.email_changeset(user, %{email: user_token.sent_to})
             |> Repo.update() do
        Repo.delete_all(
          UserToken.by_token_and_context_query(user_token.token, user_token.context)
        )

        {:ok, updated_user}
      else
        _ -> Repo.rollback({:error, :transaction_aborted})
      end
    end)
    |> case do
      {:ok, result} -> result
      {:error, reason} -> reason
    end
  end
end
