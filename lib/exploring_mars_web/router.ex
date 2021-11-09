defmodule ExploringMarsWeb.Router do
  use ExploringMarsWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExploringMarsWeb do
    pipe_through :api

    post "/send_probe_to_endpoint", ProbeController, :send_probe_to_endpoint
    post "/reset", ProbeController, :reset
  end

end
