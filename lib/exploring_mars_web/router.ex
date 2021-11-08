defmodule ExploringMarsWeb.Router do
  use ExploringMarsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExploringMarsWeb do
    pipe_through :api

    post "/create", ProbeController, :create
    post "/move", ProbeController, :move
  end

end
