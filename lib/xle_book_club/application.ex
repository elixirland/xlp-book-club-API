defmodule XleBookClub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      XleBookClubWeb.Telemetry,
      # Start the Ecto repository
      XleBookClub.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: XleBookClub.PubSub},
      # Start Finch
      {Finch, name: XleBookClub.Finch},
      # Start the Endpoint (http/https)
      XleBookClubWeb.Endpoint
      # Start a worker by calling: XleBookClub.Worker.start_link(arg)
      # {XleBookClub.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: XleBookClub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    XleBookClubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
