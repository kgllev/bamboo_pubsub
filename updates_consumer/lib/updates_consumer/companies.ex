defmodule UpdatesConsumer.Companies do
  @moduledoc """
  The Companies context.
  """

  import Ecto.Query, warn: false
  alias UpdatesConsumer.Repo

  alias UpdatesConsumer.Companies.Stock

  @doc """
  Returns the list of stocks.
  ## Examples
      iex> list_stocks()
      [%Stock{}, ...]
  """
  @spec list_stocks() :: list()
  def list_stocks do
    Repo.all(Stock)
  end

  @doc """
  Creates a stock.

  ## Examples

      iex> create_stock(%{field: value})
      {:ok, %Stock{}}

      iex> create_stock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_stock(map()) :: {:ok, Stock.t()} | {:error, Changeset.t()}
  def create_stock(attrs \\ %{}) do
    %Stock{}
    |> Stock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates or updates stock.

  ## Examples

      iex> upsert_stock(%{field: value})
      {:ok, %Stock{}}

      iex> upsert_stock(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec upsert_stock(map()) :: {:ok, Stock.t()} | {:error, Changeset.t()}
  def upsert_stock(%{symbol: symbol} = params) do
    case Repo.get_by(Stock, symbol: symbol) do
      nil ->
        create_stock(params)

      stock ->
        update_stock(stock, params)
    end
  end

  @doc """
  Updates a stock.

  ## Examples

      iex> update_stock(stock, %{field: new_value})
      {:ok, %Stock{}}

      iex> update_stock(stock, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec update_stock(Stock.t(), map()) :: {:ok, Stock.t()} | {:error, Changeset.t()}
  def update_stock(%Stock{} = stock, attrs) do
    stock
    |> Stock.changeset(attrs)
    |> Repo.update()
  end
end
