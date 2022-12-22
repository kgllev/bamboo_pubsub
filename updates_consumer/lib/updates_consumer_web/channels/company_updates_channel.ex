defmodule UpdatesConsumerWeb.CompanyUpdatesChannel do
  @moduledoc false
  use UpdatesConsumerWeb, :channel

  @impl true
  def join("company_updates:" <> _client_id, _payload, socket) do
    # TODO: Handle Authorisations
    {:ok, socket}
  end

  @impl true
  def handle_out("stock_update", payload, socket) do
    push(socket, "stock_update", payload)
    {:noreply, socket}
  end
end
