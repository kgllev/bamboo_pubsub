defmodule UpdatesConsumer.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UpdatesConsumer.Accounts` context.
  """

  @doc """
  Generate a client.
  """
  def client_fixture(attrs \\ %{}) do
    {:ok, client} =
      attrs
      |> Enum.into(%{
        email: "example@email.com"
      })
      |> UpdatesConsumer.Accounts.create_client()

    client
  end

  @doc """
  Generate a subscription.
  """
  def subscription_fixture(attrs \\ %{}) do
    {:ok, subscription} =
      attrs
      |> UpdatesConsumer.Accounts.create_subscription()

    subscription
  end
end
