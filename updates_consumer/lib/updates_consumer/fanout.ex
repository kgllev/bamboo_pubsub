defmodule UpdatesConsumer.Fanout do
  @moduledoc """
  Handles Stocks Upserts, Message Delivery to WebSockets and Sending Emails
  """
  use GenServer

  alias UpdatesConsumer.Accounts
  alias UpdatesConsumer.Companies
  alias UpdatesConsumerWeb.Adapters.MailAdapter
  alias UpdatesConsumerWeb.Adapters.SocketAdapter

  # def start_link(opts) do
  # end

  # def init() do
  # end

  def run(event) do
    event
    |> format_event
    |> upsert_company_details()
    |> list_subscriptions()
    |> send_emails()
    |> send_websocket_update()
  end

  defp send_websocket_update(%{subscribers: subscribers, stock: stock}) do
    {:ok, _pid} =
      Task.Supervisor.start_child(
        UpdatesConsumer.Fanout.WebsocketsSupervisor,
        SocketAdapter,
        :send_company_update,
        [subscribers, stock]
      )

    :ok
  end

  defp send_emails(%{subscribers: subscribers, stock: stock}) do
    {:ok, _pid} =
      Task.Supervisor.start_child(
        UpdatesConsumer.Fanout.EmailSupervisor,
        MailAdapter,
        :send_stock_email_updates,
        [subscribers, stock]
      )

    %{subscribers: subscribers, stock: stock}
  end

  defp list_subscriptions({:ok, %{id: stock_id} = stock}) do
    subscribers = Accounts.list_subscriptions(stock_id)
    %{subscribers: subscribers, stock: stock}
  end

  defp upsert_company_details(stock) do
    {:ok, stock} = Companies.upsert_stock(stock)
    stock = format_stock(stock)
    {:ok, stock}
  end

  defp format_event(event) when is_map(event) do
    %{symbol: event["S"], price: event["p"]}
  end

  defp format_event([stock | _rest]) do
    %{symbol: stock["S"], price: stock["p"]}
  end

  defp format_stock(stock) do
    stock
    |> Map.delete(:__meta__)
    |> Map.from_struct()
  end
end
