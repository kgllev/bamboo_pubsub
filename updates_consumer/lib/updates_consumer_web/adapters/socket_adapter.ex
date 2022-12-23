defmodule UpdatesConsumerWeb.Adapters.SocketAdapter do
  require Logger
  alias UpdatesConsumerWeb.Endpoint

  @doc """
  Send websocket events to all subscribers channels
  """
  @spec send_company_update(list(), map()) :: :ok
  def send_company_update(subscribers, stock) do
    :ok =
      Enum.each(
        subscribers,
        &Endpoint.broadcast("company_updates: #{&1.client.id}", "stock_update", stock)
      )

    Logger.debug("Websocket events successfully sent for #{inspect(stock)}")
  end
end
