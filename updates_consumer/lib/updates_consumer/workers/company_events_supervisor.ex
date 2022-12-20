defmodule UpdatesConsumer.Workers.CompanyEventsSupervisor do
  @moduledoc """
      Company Events Supervisor
  """
  use Supervisor

  ## API

  @spec start_link(keyword) :: Supervisor.on_start()
  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, opts, name: __MODULE__)
  end

  @spec stop(atom | pid, term, timeout) :: :ok
  def stop(name_or_pid, reason \\ :normal, timeout \\ :infinity)
      when is_atom(name_or_pid) or is_pid(name_or_pid) do
    Supervisor.stop(name_or_pid, reason, timeout)
  end

  ## Supervisor Callbacks

  @impl true
  def init(opts) do
    events_config =
      opts
      |> Keyword.merge(
        Application.get_env(:updates_consumer, UpdatesConsumer.Workers.CompanyEventsHandler)
      )

    children = [
      {UpdatesConsumer.Workers.CompanyEventsHandler, events_config}
    ]

    Supervisor.init(children, strategy: :rest_for_one)
  end
end
