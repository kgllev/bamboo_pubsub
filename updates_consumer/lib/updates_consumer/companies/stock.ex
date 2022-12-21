defmodule UpdatesConsumer.Companies.Stock do
  @moduledoc """
  Stock Schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias UpdatesConsumer.Accounts.Subscription

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "stocks" do
    field :symbol, :string
    field :price, :decimal
    has_many :subscriptions, Subscription
    timestamps()
  end

  @required_fields ~w(symbol price)a
  @doc false
  def changeset(stock, attrs) do
    stock
    |> cast(attrs, @required_fields)
    |> validate_required(@required_fields)
  end
end
