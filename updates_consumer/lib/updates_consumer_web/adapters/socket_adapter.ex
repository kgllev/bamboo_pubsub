defmodule UpdatesConsumerWeb.Adapters.SocketAdapter do
  alias UpdatesConsumerWeb.Endpoint

  @doc """
  Send websocket events to all subscribers channels
  """
  @spec send_company_update(Subscription.t(), map()) :: :ok
  def send_company_update(subscribers, stock) do
    Enum.each(
      subscribers,
      &Endpoint.broadcast("company_updates: #{&1.client.id}", "stock_update", stock)
    )
  end
end
