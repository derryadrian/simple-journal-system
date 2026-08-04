defmodule SimpleJournalSystem.Accounts.Scope do
  @moduledoc """
  Defines the scope of the caller to be used throughout the app.

  The `SimpleJournalSystem.Accounts.Scope` allows public interfaces to receive
  information about the caller, such as if the call is initiated from an
  end-user, and if so, which user. Additionally, such a scope can carry fields
  such as "super user" or other privileges for use in authorization checks,
  or to ensure specific code paths can only be accessed for a given scope.

  It is useful for logging as well as for scoping pubsub subscriptions and
  broadcasts when a caller subscribes to an interface or performs a particular
  action.

  Feel free to extend the fields on this struct to fit the needs of
  growing application requirements.
  """

  alias SimpleJournalSystem.Accounts.User
  alias SimpleJournalSystem.Roles

  defstruct user: nil, roles: []

  @doc """
  Creates a scope for the given user.

  The user's assigned role keys are loaded from the OJS user_groups tables
  and attached to the scope for authorization checks.

  Returns nil if no user is given.
  """
  def for_user(%User{} = user) do
    roles = Roles.get_user_role_atoms(user.user_id)
    %__MODULE__{user: user, roles: roles}
  end

  def for_user(nil), do: nil

  @doc "Returns true if the scope's user has the given role key."
  def has_role?(%__MODULE__{roles: roles}, role_key), do: role_key in roles
  def has_role?(_, _), do: false

  @doc "Returns true if the scope's user has any of the given role keys."
  def has_any_role?(%__MODULE__{roles: roles}, role_keys) when is_list(role_keys) do
    Enum.any?(role_keys, &(&1 in roles))
  end

  def has_any_role?(_, _), do: false

  @doc "Returns true if the scope has a user (is authenticated)."
  def authenticated?(%__MODULE__{user: %User{}}), do: true
  def authenticated?(_), do: false
end
