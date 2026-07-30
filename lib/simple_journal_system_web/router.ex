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

  pipeline :api do
    plug :accepts, ["json"]
  end

  # Halaman Utama & Fitur Umum
  scope "/", SimpleJournalSystemWeb do
    pipe_through :browser

    get "/", JournalController, :index
    get "/journals", JournalController, :index
    resources "/submissions", SubmissionController
  end

  # Rute untuk Jurnal dengan Slug (OJS Style)
  scope "/journals/:slug", SimpleJournalSystemWeb do
    pipe_through :browser

    get "/current", JournalController, :current
    get "/archive", JournalController, :archive
    
    # Rute menu Tentang Kami & Sub-halamannya
    get "/about", JournalController, :about
    get "/about/submissions", JournalController, :submissions
    get "/about/editorialTeam", JournalController, :editorial_team
    get "/about/privacy", JournalController, :privacy
    get "/about/contact", JournalController, :contact
  end

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
end