defmodule VisionHub.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VisionHubWeb.Telemetry,
      VisionHub.Repo,
      {DNSCluster, query: Application.get_env(:vision_hub, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: VisionHub.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: VisionHub.Finch},
      # Start a worker by calling: VisionHub.Worker.start_link(arg)
      # {VisionHub.Worker, arg},
      # Start to serve requests, typically the last entry
      VisionHubWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VisionHub.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VisionHubWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
