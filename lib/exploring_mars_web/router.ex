defmodule ExploringMarsWeb.Router do
  use ExploringMarsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExploringMarsWeb do
    pipe_through :api

    scope "/v1" do
      get "/get_position", ProbeController, :get_position
      post "/execute", ProbeController, :execute
      delete "/reset", ProbeController, :reset
    end
  end
end
