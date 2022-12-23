defmodule UpdatesConsumer.CompaniesTest do
  use UpdatesConsumer.DataCase

  alias UpdatesConsumer.Companies

  describe "stocks" do
    alias UpdatesConsumer.Companies.Stock

    import UpdatesConsumer.CompaniesFixtures

    @invalid_attrs %{symbol: nil, price: nil}

    test "list_stocks/0 returns all stocks" do
      stock = stock_fixture()
      assert Companies.list_stocks() == [stock]
    end

    test "create_stock/1 with valid data creates a stock" do
      valid_attrs = %{symbol: "a", price: 3.1}

      assert {:ok, %Stock{} = stock} = Companies.create_stock(valid_attrs)
      assert stock.symbol == "a"
      assert stock.price == Decimal.new("3.1")
    end

    test "create_stock/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Companies.create_stock(@invalid_attrs)
    end

    test "update_stock/2 with valid data updates the stock" do
      stock = stock_fixture()
      update_attrs = %{symbol: "z", price: 3.2}

      assert {:ok, %Stock{} = stock} = Companies.update_stock(stock, update_attrs)
      assert stock.symbol == "z"
      assert stock.price == Decimal.new("3.2")
    end

    test "update_stock/2 with invalid data returns error changeset" do
      stock = stock_fixture()
      assert {:error, %Ecto.Changeset{}} = Companies.update_stock(stock, @invalid_attrs)
    end
  end
end
