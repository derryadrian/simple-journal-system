defmodule SimpleJournalSystemWeb.Authorize do
  @moduledoc """
  Authorization helpers and plugs for role-based access control.

  Roles are the OJS role keys produced by `SimpleJournalSystem.Roles.role_id_to_key/1`:

    * `:site_admin`
    * `:manager`
    * `:editor`
    * `:reviewer`
    * `:author`

  All checks operate on `conn.assigns.current_scope`.
  """

  import Plug.Conn
  import Phoenix.Controller

  alias SimpleJournalSystem.Accounts.Scope

  @site_admin_only [:site_admin]
  @staff_roles [:site_admin, :manager, :editor]

  @doc "Returns true if the scope has any of the given role keys."
  def can?(%Scope{roles: roles}, required) when is_list(required) do
    Enum.any?(required, &(&1 in roles))
  end

  def can?(%Scope{roles: roles}, required), do: required in roles
  def can?(nil, _required), do: false

  @doc "Returns true if the scope can access the admin area."
  def admin?(scope), do: can?(scope, @site_admin_only)

  @doc "Returns true if the scope can access the editorial dashboard."
  def staff?(scope), do: can?(scope, @staff_roles)

  @doc "Returns true if the scope is at least an author."
  def contributor?(scope), do: can?(scope, [:site_admin, :manager, :editor, :author])

  @doc """
  Plug that halts with a 404 unless the scope has one of the given roles.

  Denying via 404 (rather than 403) keeps the existence of admin areas
  hidden from unauthorized users.
  """
  def require_role(conn, opts) do
    if can?(conn.assigns[:current_scope], opts[:roles]) do
      conn
    else
      conn
      |> put_status(404)
      |> put_view(SimpleJournalSystemWeb.ErrorHTML)
      |> render("404.html")
      |> halt()
    end
  end

  @doc "Requires the scope to be a site administrator."
  def require_site_admin(conn, _opts) do
    require_role(conn, roles: @site_admin_only)
  end

  @doc "Requires the scope to be editorial staff (site_admin, manager or editor)."
  def require_staff(conn, _opts) do
    require_role(conn, roles: @staff_roles)
  end

  @doc "Requires the scope to be authenticated and at least an author."
  def require_contributor(conn, _opts) do
    require_role(conn, roles: [:site_admin, :manager, :editor, :author])
  end
end
