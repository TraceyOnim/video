defmodule UploadWeb.Router do
  use UploadWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug UploadWeb.Auth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UploadWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/hello/:name", HelloController, :world
    get "/users", UserController, :index
    get "/users/:id", UserController, :show
    get "/watch/:id", WatchController, :show

    resources "/usertest", UsertestController
    resources "/sessions", SessionController, only: [:new, :create, :delete]
  end

  scope "/manage", UploadWeb do
    pipe_through [:browser, :authenticate]

    resources "/videos", VideoController
  end

  # Other scopes may use custom stacks.
  # scope "/api", UploadWeb do
  #   pipe_through :api
  # end
end
