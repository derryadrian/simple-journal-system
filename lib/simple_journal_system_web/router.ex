defmodule SimpleJournalSystemWeb.Router do
  use SimpleJournalSystemWeb, :router

  import SimpleJournalSystemWeb.UserAuth
  import SimpleJournalSystemWeb.Authorize, only: [require_site_admin: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {SimpleJournalSystemWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug :fetch_current_scope_for_user
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Site admin only - used for the role management area.
  pipeline :site_admin do
    plug :require_site_admin
  end

  scope "/", SimpleJournalSystemWeb do
    pipe_through :browser

    get "/", PageController, :home
    resources "/submissions", SubmissionController
  end

  # Other scopes may use custom stacks.
  # scope "/api", SimpleJournalSystemWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:simple_journal_system, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
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
      live "/dashboard", DashboardLive, :index
    end

    post "/users/update-password", UserSessionController, :update_password
  end

  # Role-protected admin area. Only site admins may access it.
  scope "/admin", SimpleJournalSystemWeb do
    pipe_through [:browser, :require_authenticated_user, :site_admin]

    live_session :site_admin,
      on_mount: [{SimpleJournalSystemWeb.UserAuth, :require_authenticated}] do
      live "/roles", RoleManagementLive, :index
    end
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
