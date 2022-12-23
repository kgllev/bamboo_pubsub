defmodule UpdatesConsumer.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UpdatesConsumerWeb.Telemetry,
      # Start the Ecto repository
      UpdatesConsumer.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: UpdatesConsumer.PubSub},
      # Start Finch
      {Finch, name: UpdatesConsumer.Finch},
      # Start the Endpoint (http/https)
      {Task.Supervisor, name: UpdatesConsumer.AsyncEmailSupervisor},
      UpdatesConsumerWeb.Endpoint,
      # Company updates events handler
      {UpdatesConsumer.Workers.CompanyEventsSupervisor, []},
      # Emails Task Supervisor
      {Task.Supervisor, name: UpdatesConsumer.Fanout.EmailSupervisor},
      # Websockets Task Supervisor
      {Task.Supervisor, name: UpdatesConsumer.Fanout.WebsocketsSupervisor}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: UpdatesConsumer.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UpdatesConsumerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
