defmodule XlPhoenixAPI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      XlPhoenixAPIWeb.Telemetry,
      # Start the Ecto repository
      XlPhoenixAPI.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: XlPhoenixAPI.PubSub},
      # Start Finch
      {Finch, name: XlPhoenixAPI.Finch},
      # Start the Endpoint (http/https)
      XlPhoenixAPIWeb.Endpoint
      # Start a worker by calling: XlPhoenixAPI.Worker.start_link(arg)
      # {XlPhoenixAPI.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: XlPhoenixAPI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    XlPhoenixAPIWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
