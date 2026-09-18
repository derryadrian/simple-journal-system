defmodule SimpleJournalSystem.Accounts.UserToken do
  use Ecto.Schema
  import Ecto.Query

  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserToken

  @hash_algorithm :sha256
  @rand_size 32

  @magic_link_validity_in_minutes 15
  @change_email_validity_in_days 7
  @session_validity_in_days 14

  schema "users_tokens" do
    field :token, :binary
    field :context, :string
    field :sent_to, :string
    field :authenticated_at, :utc_datetime

    belongs_to :user, User,
      foreign_key: :user_id,
      references: :user_id

    timestamps(type: :utc_datetime, updated_at: false)
  end

  ## =========================
  ## Session token
  ## =========================

  def build_session_token(%User{} = user) do
    token = :crypto.strong_rand_bytes(@rand_size)

    authenticated_at =
      user.authenticated_at || DateTime.utc_now(:second)

    user_token = %UserToken{
      token: token,
      context: "session",
      user_id: user.user_id,
      authenticated_at: authenticated_at
    }

    {token, user_token}
  end

  def verify_session_token_query(token) do
    query =
      from token in by_token_and_context_query(token, "session"),
        join: user in assoc(token, :user),
        where: token.inserted_at > ago(@session_validity_in_days, "day"),
        select: {
          %{user | authenticated_at: token.authenticated_at},
          token.inserted_at
        }

    {:ok, query}
  end

  ## =========================
  ## Email / magic-link tokens
  ## =========================

  def build_email_token(%User{} = user, context) do
    build_hashed_token(user, context, user.email)
  end

  def build_hashed_token_for_email_change(%User{} = user, email) do
    context = "change:#{email}"

    build_hashed_token(user, context, email)
  end

  defp build_hashed_token(%User{} = user, context, sent_to) do
    token = :crypto.strong_rand_bytes(@rand_size)
    hashed_token = :crypto.hash(@hash_algorithm, token)

    {
      Base.url_encode64(token, padding: false),
      %UserToken{
        token: hashed_token,
        context: context,
        sent_to: sent_to,
        user_id: user.user_id
      }
    }
  end

  ## =========================
  ## Magic link
  ## =========================

  def verify_magic_link_token_query(token) do
    case Base.url_decode64(token, padding: false) do
      {:ok, decoded_token} ->
        hashed_token =
          :crypto.hash(@hash_algorithm, decoded_token)

        query =
          from token in by_token_and_context_query(hashed_token, "login"),
            join: user in assoc(token, :user),
            where:
              token.inserted_at >
                ago(^@magic_link_validity_in_minutes, "minute"),
            where: token.sent_to == user.email,
            select: {user, token}

        {:ok, query}

      :error ->
        :error
    end
  end

  ## =========================
  ## Change email token
  ## =========================

  def verify_change_email_token_query(token, "change:") do
    case Base.url_decode64(token, padding: false) do
      {:ok, decoded_token} ->
        hashed_token =
          :crypto.hash(@hash_algorithm, decoded_token)

        query =
          from token in __MODULE__,
            join: user in assoc(token, :user),
            where: token.token == ^hashed_token,
            where: like(token.context, "change:%"),
            where:
              token.inserted_at >
                ago(@change_email_validity_in_days, "day"),
            select: {token, user}

        {:ok, query}

      :error ->
        :error
    end
  end

  def verify_change_email_token_query(_token, _context), do: :error

  ## =========================
  ## Confirmation / reset password
  ## =========================

  def verify_email_token_query(
        token,
        context
      )
      when context in ["confirm", "reset_password"] do
    case Base.url_decode64(token, padding: false) do
      {:ok, decoded_token} ->
        hashed_token =
          :crypto.hash(@hash_algorithm, decoded_token)

        query =
          from token in by_token_and_context_query(
                 hashed_token,
                 context
               ),
            join: user in assoc(token, :user),
            where:
              token.inserted_at >
                ago(@change_email_validity_in_days, "day"),
            where: token.sent_to == user.email,
            select: user

        {:ok, query}

      :error ->
        :error
    end
  end

  def verify_email_token_query(_token, _context), do: :error

  ## =========================
  ## Generic token query
  ## =========================

  def by_token_and_context_query(token, context) do
    from t in __MODULE__,
      where: t.token == ^token and t.context == ^context
  end
end
