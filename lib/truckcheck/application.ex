defmodule Truckcheck.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      TruckcheckWeb.Telemetry,
      # Start the Ecto repository
      Truckcheck.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Truckcheck.PubSub},
      # Start Finch
      {Finch, name: Truckcheck.Finch},
      # Start the Endpoint (http/https)
      TruckcheckWeb.Endpoint
      # Start a worker by calling: Truckcheck.Worker.start_link(arg)
      # {Truckcheck.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Truckcheck.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TruckcheckWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
