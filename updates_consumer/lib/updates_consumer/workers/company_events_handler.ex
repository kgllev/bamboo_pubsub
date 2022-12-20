defmodule UpdatesConsumer.Workers.CompanyEventsHandler do
  @moduledoc """
  Handles incoming Company Updates.
  """

  use Broadway
  alias Broadway.Message
  require Logger

  ## API

  @doc """
  Starts the event-stream consumer.
  """

  @spec start_link(keyword) :: Supervisor.on_start()
  def start_link(opts) do
    Broadway.start_link(__MODULE__, [name: __MODULE__] ++ opts)
  end

  ## Broadway Callbacks

  @impl true
  def handle_message(_, %Message{data: data} = message, _) do
    case Poison.decode(data) do
      {:ok, update} ->
        Logger.info("Recieved company update event #{inspect(update)}")

        :ok = collect_metrics(:processed)

        message

      error ->
        Logger.error(
          "#{__MODULE__} Error while processing Trackable Kafka events #{inspect(data)} : #{inspect(error)}"
        )

        handle_errors(error, message)
    end
  end

  defp handle_errors({error_type, reason}, message) do
    collect_metrics(error_type)

    Broadway.Message.failed(message, reason)
  end

  defp handle_errors(error, message) do
    collect_metrics(:process_error)

    Broadway.Message.failed(
      message,
      "#{__MODULE__} Event consumption failed due to application #{inspect(error)}"
    )
  end

  defp collect_metrics(status) do
    :telemetry.execute([:updates_consumer, :company_events], %{count: 1}, %{status: status})
  end
end
