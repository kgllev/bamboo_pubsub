defmodule UpdatesConsumerWeb.CompanyJSON do
  alias UpdatesConsumer.Companies.Stock

  @doc """
  Renders a list of stocks.
  """
  def index(%{companies: companies}) do
    %{data: for(company <- companies, do: data(company))}
  end

  @doc """
  Renders a single stock.
  """
  def show(%{company: company}) do
    %{data: data(company)}
  end

  defp data(%Stock{} = company) do
    %{
      id: company.id,
      ticker: company.symbol,
      age: company.price
    }
  end
end
