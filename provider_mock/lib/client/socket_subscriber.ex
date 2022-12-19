defmodule ProviderMock.Client.SocketSubscriber do
  @moduledoc """
  Gets real time trade events form Alpaca
  """

  use WebSockex
  require Logger

  alias ProviderMock.KafkaProducer

  @doc """
  Starts the data source streamer.
  """
  @spec start_link(keyword) :: Supervisor.on_start()
  def start_link(args \\ []) do
    {:ok, pid} = WebSockex.start_link(ws_endpoint(), __MODULE__, args)
    :ok = WebSockex.send_frame(pid, auth_json())

    :ok = WebSockex.send_frame(pid, subscription_json())

    :ok = Logger.info("Provider mock data source started successfully")

    {:ok, pid}
  end

  def handle_frame({:text, msg}, state) do
    :ok = Logger.debug("Received #{msg}")

    :ok = KafkaProducer.produce(msg)

    {:ok, state}
  end

  ## Private Functions

  defp subscription_json,
    do: {:text, Jason.encode!(%{"action" => "subscribe", "trades" => ["BTCUSD", "ETH", "USDT"]})}

  defp auth_json do
    params =
      Application.get_env(:provider_mock, __MODULE__)[:auth_params]
      |> Enum.into(%{})
      |> Jason.encode!()

    {:text, params}
  end

  defp ws_endpoint, do: Application.get_env(:provider_mock, __MODULE__)[:ws_url]
end
