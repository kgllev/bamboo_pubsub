defmodule UpdatesConsumerWeb.CompanyUpdatesChannelTest do
  use UpdatesConsumerWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      UpdatesConsumerWeb.UserSocket
      |> socket("user_id", %{some: :assign})
      |> subscribe_and_join(UpdatesConsumerWeb.CompanyUpdatesChannel, "company_updates:lobby")

    %{socket: socket}
  end

  test "company updates are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "stock_update", %{"some" => "data"})
    assert_push "stock_update", %{"some" => "data"}
  end
end
