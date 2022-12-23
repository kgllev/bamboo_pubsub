defmodule UpdatesConsumer.AccountsTest do
  use UpdatesConsumer.DataCase

  import UpdatesConsumer.AccountsFixtures
  import UpdatesConsumer.CompaniesFixtures

  alias UpdatesConsumer.Accounts
  alias UpdatesConsumer.Accounts.Client
  alias UpdatesConsumer.Accounts.Subscription

  describe "clients" do
    @invalid_attrs %{email: nil}

    test "create_client/1 with valid data creates a client" do
      valid_attrs = %{email: "someemail@domain.com"}

      assert {:ok, %Client{} = client} = Accounts.create_client(valid_attrs)
      assert client.email == "someemail@domain.com"
    end

    test "create_client/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_client(@invalid_attrs)
    end
  end

  describe "subscriptions" do
    @invalid_attrs %{client_id: nil, stock_id: nil}

    test "list_subscriptions/1 returns all stock subscriptions" do
      client = client_fixture()
      stock = stock_fixture()
      subscription_fixture(%{client_id: client.id, stock_id: stock.id})

      assert is_list(Accounts.list_subscriptions(stock.id))
    end

    test "create_subscription/1 with valid data creates a subscription" do
      client = client_fixture()
      stock = stock_fixture()

      valid_attrs = %{client_id: client.id, stock_id: stock.id}

      assert {:ok, %Subscription{} = subscription} = Accounts.create_subscription(valid_attrs)
      assert subscription.client_id == client.id
      assert subscription.stock_id == stock.id
    end

    test "create_subscription/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Accounts.create_subscription(@invalid_attrs)
    end
  end
end
