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
    field :confirmed_at, :naive_datetime, source: :date_validated

    # Virtual fields untuk kompatibilitas dengan phx.gen.auth
    field :inserted_at, :naive_datetime, virtual: true
    field :updated_at, :naive_datetime, virtual: true
    field :authenticated_at, :utc_datetime, virtual: true

    field :date_last_login, :naive_datetime
    field :must_change_password, :integer
    field :disabled, :integer
    field :inline_help, :integer
    field :auth_id, :integer
    field :auth_str, :string
    field :disabled_reason, :string
    field :remember_token, :string

    # Virtual fields untuk registration & password
    field :password, :string, virtual: true, redact: true
    field :password_confirmation, :string, virtual: true, redact: true
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
      :confirmed_at,
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
    |> validate_length(:username, min: 3, max: 32)
    |> validate_format(
      :username,
      ~r/^[a-zA-Z0-9._-]+$/,
      message: "username hanya boleh mengandung huruf, angka, titik, underscore, dan tanda hubung"
    )
    |> validate_format(
      :email,
      ~r/^[^\s@]+@[^\s@]+\.[^\s@]+$/,
      message: "format email tidak valid"
    )
    |> validate_length(:email, max: 255)
    |> validate_confirmation(:password, message: "tidak sama dengan password")
    |> validate_length(:password, min: 12, max: 72)
    |> put_password_hash()
    |> put_user_id()
    |> put_default_values()
    |> unsafe_validate_unique(:username, SimpleJournalSystem.Repo)
    |> unsafe_validate_unique(:email, SimpleJournalSystem.Repo)
    |> unique_constraint(:username, name: :users_username_unique)
    |> unique_constraint(:email, name: :users_email_unique)
  end

  def email_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email])
    |> validate_required([:email])
    |> validate_format(
      :email,
      ~r/^[^\s@]+@[^\s@]+\.[^\s@]+$/,
      message: "format email tidak valid"
    )
    |> validate_length(:email, max: 255)
    |> maybe_validate_unique_email(opts)
  end

 defp maybe_validate_unique_email(changeset, opts) do
    if Keyword.get(opts, :validate_unique, true) do
      changeset
      |> unsafe_validate_unique(:email, SimpleJournalSystem.Repo)
      |> unique_constraint(:email, name: :users_email_unique)
    else
      changeset
    end
  end
  
  def password_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:password, :password_confirmation])
    |> validate_required([:password])
    |> validate_length(:password, min: 12)
    |> validate_length(:password, max: 72)
    |> validate_confirmation(:password, message: "does not match password")
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    if Keyword.get(opts, :hash_password, true) do
      put_password_hash(changeset)
    else
      changeset
    end
  end

  def confirm_changeset(user) do
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    user
    |> change(confirmed_at: now)
  end

  def validate_current_password(changeset, password) do
    if Bcrypt.verify_pass(password, changeset.data.hashed_password || "") do
      changeset
    else
      add_error(changeset, :current_password, "is not valid")
    end
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    changeset
    |> change(hashed_password: Bcrypt.hash_pwd_salt(password))
    |> delete_change(:password)
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