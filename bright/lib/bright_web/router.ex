defmodule BrightWeb.Router do
  use BrightWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {BrightWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BrightWeb do
    pipe_through :browser

    live "/skill_units", SkillUnitLive.Index, :index
    live "/skill_units/new", SkillUnitLive.Index, :new
    live "/skill_units/:id/edit", SkillUnitLive.Index, :edit
    live "/skill_units/:id", SkillUnitLive.Show, :show
    live "/skill_units/:id/show/edit", SkillUnitLive.Show, :edit

    live "/skill_categories", SkillCategoryLive.Index, :index
    live "/skill_categories/new", SkillCategoryLive.Index, :new
    live "/skill_categories/:id/edit", SkillCategoryLive.Index, :edit
    live "/skill_categories/:id", SkillCategoryLive.Show, :show
    live "/skill_categories/:id/show/edit", SkillCategoryLive.Show, :edit

    live "/skills", SkillLive.Index, :index
    live "/skills/new", SkillLive.Index, :new
    live "/skills/:id/edit", SkillLive.Index, :edit
    live "/skills/:id", SkillLive.Show, :show
    live "/skills/:id/show/edit", SkillLive.Show, :edit

    live "/skill_scores", SkillScoreLive.Index, :index
    live "/skill_scores/new", SkillScoreLive.Index, :new
    live "/skill_scores/:id/edit", SkillScoreLive.Index, :edit
    live "/skill_scores/:id", SkillScoreLive.Show, :show
    live "/skill_scores/:id/show/edit", SkillScoreLive.Show, :edit 

    get "/", PageController, :home
  end

  # Other scopes may use custom stacks.
  # scope "/api", BrightWeb do
  #   pipe_through :api
  # end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:bright, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: BrightWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
