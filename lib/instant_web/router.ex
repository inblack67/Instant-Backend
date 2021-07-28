defmodule InstantWeb.Router do
  use InstantWeb, :router

  alias InstantWeb.Plugs.SetUser
  alias InstantWeb.Plugs.SetGraphqlAuth
  alias InstantWeb.AuthController

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
    plug SetUser
  end

  pipeline :graphql do
    plug :accepts, ["json"]
    plug :fetch_session
    plug SetGraphqlAuth
  end

  scope "/api" do
    pipe_through :api

    get "/auth", AuthController, :index
    post "/auth", AuthController, :create
    post "/auth/register", AuthController, :register
    delete "/auth/logout", AuthController, :delete
  end

  scope "/api/graphql" do
    pipe_through :graphql

    get "/", Absinthe.Plug.GraphiQL,
      schema: InstantWeb.Schema,
      interface: :playground,
      socket: InstantWeb.UserSocket

    post "/", Absinthe.Plug, schema: InstantWeb.Schema
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: InstantWeb.Telemetry
    end
  end
end
