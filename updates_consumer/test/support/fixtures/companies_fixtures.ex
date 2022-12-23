defmodule UpdatesConsumer.CompaniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `UpdatesConsumer.Companies` context.
  """

  @doc """
  Generate a stock.
  """
  def stock_fixture(attrs \\ %{}) do
    {:ok, stock} =
      attrs
      |> Enum.into(%{
        symbol: "e",
        price: 1.2
      })
      |> UpdatesConsumer.Companies.create_stock()

    stock
  end
end
