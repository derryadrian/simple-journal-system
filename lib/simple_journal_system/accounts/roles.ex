defmodule SimpleJournalSystem.Accounts.Roles do
  @moduledoc """
  OJS Role constants based on actual data in ojs_db_wsl.
  """

  @manager 1
  @site_admin 16
  @journal_manager 17
  @reviewer 4096
  @editor 4097
  @author 65536
  @assistant 8192
  @reader 1048576
  @subscription_manager 2097152

  @all [
    @manager,
    @site_admin,
    @journal_manager,
    @reviewer,
    @editor,
    @author,
    @reader,
    @subscription_manager
  ]

  @doc """
  Returns all defined role IDs.
  """
  def all, do: @all

  @doc """
  Returns role ID for manager.
  """
  def manager, do: @manager

  @doc """
  Returns role ID for site admin.
  """
  def site_admin, do: @site_admin

  @doc """
  Returns role ID for journal manager.
  """
  def journal_manager, do: @journal_manager

  @doc """
  Returns role ID for reviewer.
  """
  def reviewer, do: @reviewer

  @doc """
  Returns role ID for editor.
  """
  def editor, do: @editor

  @doc """
  Returns role ID for author.
  """
  def author, do: @author

  @doc """
  Returns role ID for reader.
  """
  def reader, do: @reader

  @doc """
  Returns role ID for assistant.
  """
  def assistant, do: @assistant

  @doc """
  Returns role ID for subscription manager.
  """
  def subscription_manager, do: @subscription_manager

  @doc """
  Returns human-readable name for role ID.
  """
  def name(role_id) do
    case role_id do
      @manager -> "Manager"
      @site_admin -> "Site Admin"
      @journal_manager -> "Journal Manager"
      @reviewer -> "Reviewer"
      @editor -> "Editor"
      @author -> "Author"
      @reader -> "Reader"
      @subscription_manager -> "Subscription Manager"
      _ -> "Unknown (#{role_id})"
    end
  end

  @doc """
  Checks if role_id is valid.
  """
  def valid?(role_id), do: role_id in @all

  @doc """
  Returns role IDs that can access editorial workflow.
  """
  def editorial_roles, do: [@manager, @site_admin, @journal_manager, @editor, @reviewer]
end