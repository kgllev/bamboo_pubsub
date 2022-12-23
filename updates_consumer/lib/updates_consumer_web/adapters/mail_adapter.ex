defmodule UpdatesConsumerWeb.Adapters.MailAdapter do
  import Swoosh.Email
  require Logger

  @doc """
  Send emails of updates to all clients
  """
  @spec send_stock_email_updates(list(), map()) :: :ok
  def send_stock_email_updates(subscribers, stock) do
    Enum.each(subscribers, fn subscriber ->
      Task.Supervisor.start_child(UpdatesConsumer.AsyncEmailSupervisor, fn ->
        stock_update_email(subscriber.client, stock)
        |> UpdatesConsumer.Mailer.deliver()
      end)
    end)

    Logger.debug("All emails successfully sent for #{inspect(stock)}")
  end

  ## Private functions

  defp stock_update_email(client, stock) do
    new()
    |> to(client.email)
    |> from({"Ike", "updates@bambooinvestments.com"})
    |> subject("Hello !")
    |> html_body(
      "<h1>Hello #{client.email}</h1>, <p>New Price Change for #{stock.symbol} is #{stock.price}"
    )
  end
end
