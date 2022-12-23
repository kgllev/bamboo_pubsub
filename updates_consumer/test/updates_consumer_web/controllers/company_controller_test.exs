defmodule UpdatesConsumerWeb.StockControllerTest do
  use UpdatesConsumerWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all company stocks", %{conn: conn} do
      conn = get(conn, ~p"/api/companies")
      assert json_response(conn, 200)["data"] == []
    end
  end
end
