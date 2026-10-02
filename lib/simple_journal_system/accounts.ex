defmodule SimpleJournalSystem.Accounts do
  import Ecto.Query
  alias SimpleJournalSystem.Repo
  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Accounts.UserToken
  alias SimpleJournalSystem.Accounts.UserGroup
  alias SimpleJournalSystem.Accounts.UserGroupSetting
  alias SimpleJournalSystem.Accounts.UserGroupStage
  alias SimpleJournalSystem.Accounts.UserUserGroup
  alias SimpleJournalSystem.Accounts.Roles
  alias SimpleJournalSystem.Accounts.Stages
  alias SimpleJournalSystem.Journals.Journal

  ## Database getters

  # Diubah: mendukung login dengan email ATAU username
  def get_user_by_email(email) do
    get_user_by_email_or_username(email)
  end

  defp get_user_by_email_or_username(login) do
    query = from u in User,
            where: u.email == ^login or u.username == ^login,
            limit: 1
    Repo.one(query)
  end

  # Fungsi login utama – mendukung Bcrypt DAN legacy SHA1 (OJS)
  def get_user_by_email_and_password(email, password) do
    user = get_user_by_email_or_username(email)
    if user && verify_password(password, user.hashed_password) do
      maybe_upgrade_hash(user, password)
      user
    else
      nil
    end
  end

  @doc """
  Verifies password against hash. Supports:
  - Bcrypt (current)
  - OJS SHA1 legacy: sha1$salt$hash or plain SHA1
  """
  defp verify_password(password, hashed) do
    cond do
      is_nil(hashed) or hashed == "" ->
        false
      String.starts_with?(hashed, "$2b$") or String.starts_with?(hashed, "$2a$") or String.starts_with?(hashed, "$2y$") ->
        Bcrypt.verify_pass(password, hashed)
      String.contains?(hashed, "$") ->
        verify_sha1_legacy(password, hashed)
      true ->
        # Plain SHA1 (40 hex chars)
        :crypto.hash(:sha, password) |> Base.encode16(case: :lower) == hashed
    end
  end

  @doc """
  Verifies OJS legacy SHA1 format: algorithm$salt$hash
  Common formats:
  - sha1$salt$hash
  - sha256$salt$hash
  - md5$salt$hash
  """
  defp verify_sha1_legacy(password, hashed) do
    parts = String.split(hashed, "$", parts: 3)
    case parts do
      [algo, salt, hash] ->
        computed =
          case algo do
            "sha1" -> :crypto.hash(:sha, salt <> password)
            "sha256" -> :crypto.hash(:sha256, salt <> password)
            "md5" -> :crypto.hash(:md5, salt <> password)
            _ -> :crypto.hash(:sha, salt <> password)
          end
        Base.encode16(computed, case: :lower) == hash
      _ ->
        false
    end
  end

  @doc """
  Upgrades legacy hash to Bcrypt on successful login.
  """
  defp maybe_upgrade_hash(user, password) do
    hashed = user.hashed_password
    if hashed && !String.starts_with?(hashed, "$2b$") and !String.starts_with?(hashed, "$2a$") and !String.starts_with?(hashed, "$2y$") do
      new_hash = Bcrypt.hash_pwd_salt(password)
      Repo.update(%User{user | hashed_password: new_hash})
      :ok
    else
      :ok
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
         {:ok, %{}} <- User.email_changeset(user, %{email: token_context(token)}) |> User.validate_current_password(password) |> Repo.update() do
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

  ## User Group CRUD (D)

  @doc """
  Lists all user groups for a journal.
  """
  def list_user_groups(journal_id) do
    Repo.all(from ug in UserGroup, where: ug.context_id == ^journal_id, order_by: ug.role_id)
  end

  @doc """
  Gets a single user group by ID.
  """
  def get_user_group!(id), do: Repo.get!(UserGroup, id)

  @doc """
  Creates a user group for a journal.
  """
  def create_user_group(attrs) do
    %UserGroup{}
    |> UserGroup.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a user group.
  """
  def update_user_group(%UserGroup{} = group, attrs) do
    group
    |> UserGroup.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a user group. Prevents deletion if users are assigned.
  """
  def delete_user_group(%UserGroup{} = group) do
    count = Repo.one(from uug in UserUserGroup, where: uug.user_group_id == ^group.user_group_id, select: count(uug.id))
    if count > 0 do
      {:error, :has_assigned_users}
    else
      Repo.delete(group)
    end
  end

  @doc """
  Sets a user group as default for a journal.
  """
  def set_default_group(journal_id, user_group_id) do
    Repo.transaction(fn ->
      Repo.update_all(UserGroup, set: [is_default: 0], where: [context_id: journal_id])
      Repo.update_all(UserGroup, set: [is_default: 1], where: [user_group_id: user_group_id])
    end)
  end

  ## User Group Settings (D)

  @doc """
  Gets localized settings for a user group.
  """
  def get_user_group_settings(user_group_id, locale \\ "en") do
    Repo.all(from ugs in UserGroupSetting,
      where: ugs.user_group_id == ^user_group_id and ugs.locale == ^locale)
  end

  @doc """
  Sets a localized setting for a user group.
  """
  def put_user_group_setting(user_group_id, setting_name, setting_value, locale \\ "en") do
    Repo.transaction(fn ->
      existing = Repo.one(from ugs in UserGroupSetting,
        where: ugs.user_group_id == ^user_group_id and ugs.setting_name == ^setting_name and ugs.locale == ^locale)
      if existing do
        Repo.update(%UserGroupSetting{existing | setting_value: setting_value})
      else
        Repo.insert(%UserGroupSetting{user_group_id: user_group_id, setting_name: setting_name, setting_value: setting_value, locale: locale})
      end
    end)
  end

  ## Stage Assignment (F)

  @doc """
  Sets stages accessible by a user group in a journal.
  """
  def set_stages(user_group_id, journal_id, stage_ids) do
    Repo.transaction(fn ->
      Repo.delete_all(from ugs in UserGroupStage, where: ugs.user_group_id == ^user_group_id and ugs.context_id == ^journal_id)
      Enum.each(stage_ids, fn stage_id ->
        if Stages.valid?(stage_id) do
          Repo.insert!(%UserGroupStage{user_group_id: user_group_id, context_id: journal_id, stage_id: stage_id})
        end
      end)
    end)
    {:ok, :stages_updated}
  end

  @doc """
  Gets stages assigned to a user group.
  """
  def stages_for_group(user_group_id) do
    Repo.all(from ugs in UserGroupStage,
      where: ugs.user_group_id == ^user_group_id,
      select: ugs.stage_id)
  end

  @doc """
  Gets stages assigned to a user group for a specific journal.
  """
  def stages_for_group_in_journal(user_group_id, journal_id) do
    Repo.all(from ugs in UserGroupStage,
      where: ugs.user_group_id == ^user_group_id and ugs.context_id == ^journal_id,
      select: ugs.stage_id)
  end

  ## User Settings EAV (C)

  @doc """
  Gets a user setting value.
  """
  def get_setting(user, key, locale \\ "en") do
    Repo.one(from us in UserSetting,
      where: us.user_id == ^user.user_id and us.setting_name == ^key and us.locale == ^locale,
      select: us.setting_value)
  end

  @doc """
  Gets a user setting value with fallback locale.
  """
  def get_setting(user, key, locale, fallback_locale) do
    get_setting(user, key, locale) || get_setting(user, key, fallback_locale)
  end

  @doc """
  Sets a user setting value (upsert).
  """
  def put_setting(user, key, value, locale \\ "en") do
    Repo.transaction(fn ->
      existing = Repo.one(from us in UserSetting,
        where: us.user_id == ^user.user_id and us.setting_name == ^key and us.locale == ^locale)
      if existing do
        Repo.update(%{existing | setting_value: value})
      else
        Repo.insert(%{user_id: user.user_id, setting_name: key, setting_value: value, locale: locale})
      end
    end)
  end

  @doc """
  Gets all settings for a user as a map.
  """
  def get_all_settings(user, locale \\ "en") do
    Repo.all(from us in UserSetting,
      where: us.user_id == ^user.user_id and us.locale == ^locale,
      select: {us.setting_name, us.setting_value})
    |> Enum.into(%{})
  end

  @doc """
  Returns user profile map from settings.
  """
  def get_profile(user, locale \\ "en") do
    settings = get_all_settings(user, locale)
    %{
      given_name: settings["givenName"] || settings["firstName"],
      family_name: settings["familyName"] || settings["lastName"],
      affiliation: settings["affiliation"],
      orcid: settings["orcid"],
      country: settings["country"] || user.country,
      email: user.email,
      username: user.username,
      url: user.url,
      phone: user.phone,
      mailing_address: user.mailing_address,
      billing_address: user.billing_address,
      biography: settings["biography"],
      locale: settings["locale"] || locale
    }
  end

  @doc """
  Updates user profile from attrs (uses put_setting for EAV fields).
  """
  def update_profile(user, attrs) do
    eav_fields = ["givenName", "familyName", "affiliation", "orcid", "country", "biography", "locale"]

    Repo.transaction(fn ->
      Enum.each(eav_fields, fn field ->
        if Map.has_key?(attrs, field) do
          put_setting(user, field, attrs[field])
        end
      end)

      # Update direct fields on users table
      direct_fields = Map.take(attrs, ["email", "username", "url", "phone", "mailing_address", "billing_address"])
      if direct_fields != %{} do
        user
        |> User.changeset(direct_fields)
        |> Repo.update()
      end
    end)
  end

  @doc """
  Suspends a user account (soft disable).
  """
  def suspend_user(user, reason) do
    Repo.update(%User{user | disabled: 1, disabled_reason: reason})
  end

  @doc """
  Activates a suspended user account.
  """
  def activate_user(user) do
    Repo.update(%User{user | disabled: 0, disabled_reason: nil})
  end

  ## User Role Assignment (E)

  @doc """
  Enrolls a user into a user group (role).
  """
  def enroll_user(user_id, user_group_id) do
    Repo.transaction(fn ->
      _user = Repo.get!(User, user_id)
      _group = Repo.get!(UserGroup, user_group_id)

      # Check if already enrolled
      existing = Repo.one(from uug in UserUserGroup,
        where: uug.user_id == ^user_id and uug.user_group_id == ^user_group_id)
      
      if existing do
        {:error, :already_enrolled}
      else
        Repo.insert!(%UserUserGroup{
          user_id: user_id,
          user_group_id: user_group_id,
          date_start: NaiveDateTime.utc_now()
        })
        {:ok, :enrolled}
      end
    end)
  end

  @doc """
  Unenrolls a user from a user group (role).
  """
  def unenroll_user(user_id, user_group_id) do
    Repo.transaction(fn ->
      deleted = Repo.delete_all(from uug in UserUserGroup,
        where: uug.user_id == ^user_id and uug.user_group_id == ^user_group_id)
      if deleted > 0 do
        {:ok, :unenrolled}
      else
        {:error, :not_enrolled}
      end
    end)
  end

  @doc """
  Lists all roles for a user across all journals.
  Returns list of %{journal_id:, journal_path:, role_id:, role_name:, group_id:, is_default:}
  """
  def list_user_roles(user_id) do
    Repo.all(
      from uug in UserUserGroup,
      join: ug in UserGroup,
      on: uug.user_group_id == ug.user_group_id,
      join: j in Journal,
      on: ug.context_id == j.journal_id,
      where: uug.user_id == ^user_id,
      select: %{
        journal_id: j.journal_id,
        journal_path: j.path,
        role_id: ug.role_id,
        group_id: ug.user_group_id,
        is_default: ug.is_default == 1,
        date_start: uug.date_start,
        date_end: uug.date_end
      }
    )
    |> Enum.map(fn r ->
      Map.put(r, :role_name, Roles.name(r.role_id))
    end)
  end

  @doc """
  Lists user roles for a specific journal.
  """
  def list_user_roles_in_journal(user_id, journal_id) do
    Repo.all(
      from uug in UserUserGroup,
      join: ug in UserGroup,
      on: uug.user_group_id == ug.user_group_id,
      where: uug.user_id == ^user_id and ug.context_id == ^journal_id,
      select: %{
        role_id: ug.role_id,
        group_id: ug.user_group_id,
        is_default: ug.is_default == 1,
        date_start: uug.date_start,
        date_end: uug.date_end
      }
    )
    |> Enum.map(fn r ->
      Map.put(r, :role_name, Roles.name(r.role_id))
    end)
  end

  @doc """
  Bulk enrolls multiple users into a user group.
  """
  def bulk_enroll(user_ids, user_group_id) do
    Repo.transaction(fn ->
      _group = Repo.get!(UserGroup, user_group_id)
      results = Enum.map(user_ids, fn user_id ->
        case enroll_user(user_id, user_group_id) do
          {:ok, _} -> {:ok, user_id}
          {:error, :already_enrolled} -> {:skipped, user_id}
          error -> error
        end
      end)
      {:ok, results}
    end)
  end
end