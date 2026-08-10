defmodule SimpleJournalSystem.Accounts do
  import Ecto.Query
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserToken

  ## Database getters

  # Diubah: mendukung login dengan email ATAU username
  def get_user_by_email(email) do
    get_user_by_email_or_username(email)
  end

  defp get_user_by_email_or_username(login) do
    query =
      from u in User,
        where: u.email == ^login or u.username == ^login,
        limit: 1

    Repo.one(query)
  end

  # Fungsi login utama – mengembalikan user atau nil (bukan tuple)
  def get_user_by_email_and_password(email, password) do
    user = get_user_by_email_or_username(email)

    if user && Bcrypt.verify_pass(password, user.hashed_password) do
      user
    else
      nil
    end
  end

  # Fungsi lain tetap seperti bawaan Phoenix (tidak diubah)
  def get_user_by_session_token(token) do
    {:ok, query} = UserToken.verify_session_token_query(token)
    Repo.one(query)
  end

  def get_user_by_session_token(user_id) when is_integer(user_id) do
    Repo.get(User, user_id)
  end

  ## Session token management (tetap pakai UserToken jika ada)
  def generate_user_session_token(user) do
    {token, user_token} = UserToken.build_session_token(user)
    Repo.insert!(user_token)
    token
  end

  def delete_user_session_token(token) do
    Repo.delete_all(UserToken.by_token_and_context_query(token, "session"))
    :ok
  end

  ## Registration (tetap ada, tapi kita bisa nonaktifkan route-nya)
  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def change_user_registration(%User{} = user, attrs) do
    User.registration_changeset(user, attrs)
  end

  ## Email and password updates (tetap ada)
  def change_user_email(user, attrs) do
    User.email_changeset(user, attrs)
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

  ## Confirmation (jika dipakai)
  def deliver_user_confirmation_instructions(%User{} = user) do
    {encoded_token, user_token} = UserToken.build_email_token(user, "confirm")
    Repo.insert!(user_token)
    SimpleJournalSystem.Emails.deliver_confirmation_instructions(user, encoded_token)
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

  ## Reset password (jika dipakai)
  def deliver_user_reset_password_instructions(%User{} = user) do
    {encoded_token, user_token} = UserToken.build_email_token(user, "reset_password")
    Repo.insert!(user_token)
    SimpleJournalSystem.Emails.deliver_reset_password_instructions(user, encoded_token)
  end

  def reset_user_password(token, attrs) do
    with {:ok, query} <- UserToken.verify_email_token_query(token, "reset_password"),
         %User{} = user <- Repo.one(query),
         {:ok, %{}} <- User.password_changeset(user, attrs) |> Repo.update() do
      {:ok, user}
    else
      _ -> :error
    end
  end

  ## Update email dengan konfirmasi
  def deliver_user_update_email_instructions(%User{} = user, email) do
    {encoded_token, user_token} = UserToken.build_email_token(user, "change:#{email}")
    Repo.insert!(user_token)
    SimpleJournalSystem.Emails.deliver_update_email_instructions(user, email, encoded_token)
  end

  def update_user_email(token, password) do
    with {:ok, query} <- UserToken.verify_email_token_query(token, "change"),
         %User{} = user <- Repo.one(query),
         {:ok, %{}} <-
           User.email_changeset(user, %{email: token_context(token)})
           |> User.validate_current_password(password)
           |> Repo.update() do
      {:ok, user}
    else
      _ -> :error
    end
  end

  defp token_context(token) do
    # helper untuk ekstrak email dari token_context (format "change:email@domain.com")
    token
    |> String.split(":", parts: 2)
    |> List.last()
  end
end
