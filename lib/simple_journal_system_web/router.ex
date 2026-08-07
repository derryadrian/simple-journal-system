defmodule SimpleJournalSystemWeb.Router do
  use SimpleJournalSystemWeb, :router

  import SimpleJournalSystemWeb.UserAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SimpleJournalSystemWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_scope_for_user
  end

  pipeline :admin do
    plug :require_authenticated_user
    plug :require_admin
  end

  pipeline :author do
    plug :require_authenticated_user
    plug :require_author
  end

  pipeline :editor do
    plug :require_authenticated_user
    plug :require_editor
  end

  pipeline :reviewer do
    plug :require_authenticated_user
    plug :require_reviewer
  end

    pipeline :manager do
    plug :require_authenticated_user
    plug :require_manager
  end

  pipeline :assistant do
    plug :require_authenticated_user
    plug :require_assistant
  end

  pipeline :reader do
    plug :require_authenticated_user
    plug :require_reader
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SimpleJournalSystemWeb do
    pipe_through :browser

    get "/", PageController, :home
    resources "/submissions", SubmissionController
  end

  scope "/admin", SimpleJournalSystemWeb do
    pipe_through [:browser, :admin]

    get "/", PageController, :home
  end

  # Menggunakan live_session untuk rute LiveView Author agar aman di level WebSocket
  scope "/author", SimpleJournalSystemWeb do
    pipe_through [:browser, :author]

    live_session :author_area,
      on_mount: [{SimpleJournalSystemWeb.UserAuth, :require_authenticated}] do
      live "/", AuthorLive, :index
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", SimpleJournalSystemWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:simple_journal_system, :dev_routes) do
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: SimpleJournalSystemWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end

  ## Authentication routes

  scope "/", SimpleJournalSystemWeb do
    pipe_through [:browser, :require_authenticated_user]

    live_session :require_authenticated_user,
      on_mount: [{SimpleJournalSystemWeb.UserAuth, :require_authenticated}] do
      live "/users/settings", UserLive.Settings, :edit
      live "/users/settings/confirm-email/:token", UserLive.Settings, :confirm_email
    end

    post "/users/update-password", UserSessionController, :update_password
  end

  scope "/", SimpleJournalSystemWeb do
    pipe_through [:browser]

    live_session :current_user,
      on_mount: [{SimpleJournalSystemWeb.UserAuth, :mount_current_scope}] do
      live "/users/register", UserLive.Registration, :new
      live "/users/log-in", UserLive.Login, :new
      live "/users/log-in/:token", UserLive.Confirmation, :new
    end

    post "/users/log-in", UserSessionController, :create
    delete "/users/log-out", UserSessionController, :delete
  end
end
