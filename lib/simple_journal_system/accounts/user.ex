defmodule SimpleJournalSystem.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_id, :id, []}
  @derive {Phoenix.Param, key: :user_id}
  @derive {Inspect, except: [:password, :password_confirmation]}

  schema "users" do

    field :username, :string
    field :hashed_password, :string, source: :password
    field :email, :string

    has_many :user_user_groups,
             SimpleJournalSystem.Accounts.UserUserGroup,
             foreign_key: :user_id

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
    field :confirmed_at, :naive_datetime, source: :date_validated
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
      message: "must have the @ sign and no spaces"
    )
    |> validate_length(:email, max: 160)
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_length(:password, min: 6)
    |> unsafe_validate_unique(:email, SimpleJournalSystem.Repo)
    |> unsafe_validate_unique(:username, SimpleJournalSystem.Repo)
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

  def email_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:email])
    |> validate_format(:email, ~r/^[^\s@]+@[^\s@]+$/,
      message: "must have the @ sign and no spaces"
    )
    |> validate_length(:email, max: 160)
    |> validate_required([:email])
    |> maybe_validate_unique_email(opts)
  end

  defp maybe_validate_unique_email(changeset, opts) do
    if Keyword.get(opts, :validate_unique, true) do
      changeset
      |> unsafe_validate_unique(:email, SimpleJournalSystem.Repo)
      |> unique_constraint(:email)
    else
      changeset
    end
  end

  def password_changeset(user, attrs, opts \\ []) do
    user
    |> cast(attrs, [:password])
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_length(:password, min: 12, max: 72)
    |> validate_required([:password])
    |> maybe_hash_password(opts)
  end

  defp maybe_hash_password(changeset, opts) do
    if Keyword.get(opts, :hash_password, true) do
      changeset
      |> put_password_hash()
    else
      changeset
    end
  end

  def confirm_changeset(user) do
    change(user, confirmed_at: DateTime.utc_now(:second))
  end

  def validate_current_password(changeset, password) do
    changeset
    |> validate_confirmation(:password, message: "does not match password")
    |> validate_length(:password, min: 12, max: 72)
    |> validate_current_password_hashed(password)
  end

  defp validate_current_password_hashed(changeset, password) do
    if is_nil(get_change(changeset, :hashed_password)) do
      current_password = get_field(changeset, :hashed_password)

      if is_nil(current_password) do
        changeset
      else
        if Bcrypt.verify_pass(password, current_password) do
          changeset
        else
          add_error(changeset, :hashed_password, "is not valid")
        end
      end
    else
      changeset
    end
  end

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
