defmodule SimpleJournalSystem.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_id, :id, []}
  @derive {Phoenix.Param, key: :user_id}

  schema "users" do
    field :username, :string
    field :hashed_password, :string, source: :password
    field :email, :string
    field :url, :string
    field :phone, :string
    field :mailing_address, :string
    field :billing_address, :string
    field :country, :string
    field :locales, :string
    field :gossip, :string
    field :date_last_email, :naive_datetime
    field :date_registered, :naive_datetime
    field :date_validated, :naive_datetime

    # === Virtual fields untuk kompatibilitas dengan phx.gen.auth ===
    field :confirmed_at, :naive_datetime, virtual: true
    field :inserted_at, :naive_datetime, virtual: true
    field :updated_at, :naive_datetime, virtual: true
    # BARU
    field :authenticated_at, :naive_datetime, virtual: true

    field :date_last_login, :naive_datetime
    field :must_change_password, :integer
    field :disabled, :integer
    field :inline_help, :integer
    field :auth_id, :integer
    field :auth_str, :string
    field :disabled_reason, :string
    field :remember_token, :string

    # === Virtual fields untuk registration ===
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
  end

  def changeset(user, attrs) do
    user
    |> cast(attrs, [
      :username,
      :hashed_password,
      :email,
      :url,
      :phone,
      :mailing_address,
      :billing_address,
      :country,
      :locales,
      :gossip,
      :date_last_email,
      :date_registered,
      :date_validated,
      :date_last_login,
      :must_change_password,
      :auth_id,
      :auth_str,
      :disabled,
      :disabled_reason,
      :inline_help,
      :remember_token
    ])
    |> validate_required([:username, :email])
  end

  def registration_changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :password_confirmation])
    |> validate_required([:username, :email, :password])
    |> validate_length(:username, min: 3, max: 100)
    |> validate_format(:email, ~r/^[^\s@]+@[^\s@]+\.[^\s@]+$/,
      message: "format email tidak valid"
    )
    |> validate_confirmation(:password, message: "tidak sama dengan password")
    |> validate_length(:password, min: 6)
    |> put_password_hash()
    |> put_user_id()
    |> put_default_values()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, hashed_password: Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset), do: changeset

  defp put_user_id(changeset) do
    case changeset.valid? do
      true ->
        max_id = SimpleJournalSystem.Repo.aggregate(__MODULE__, :max, :user_id) || 0
        change(changeset, user_id: max_id + 1)

      false ->
        changeset
    end
  end

  defp put_default_values(changeset) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    changeset
    |> change(%{
      date_registered: now,
      disabled: 0,
      inline_help: 1
    })
  end
end
