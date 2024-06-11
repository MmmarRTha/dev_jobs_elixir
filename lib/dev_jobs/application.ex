defmodule DevJobs.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      DevJobsWeb.Telemetry,
      DevJobs.Repo,
      {DNSCluster, query: Application.get_env(:dev_jobs, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: DevJobs.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: DevJobs.Finch},
      # Start a worker by calling: DevJobs.Worker.start_link(arg)
      # {DevJobs.Worker, arg},
      # Start to serve requests, typically the last entry
      DevJobsWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DevJobs.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    DevJobsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
