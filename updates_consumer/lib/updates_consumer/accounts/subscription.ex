defmodule UpdatesConsumer.Accounts.Subscription do
  @moduledoc """
  Subscription Schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias UpdatesConsumer.Accounts.Client
  alias UpdatesConsumer.Companies.Stock

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "subscriptions" do
    belongs_to :client, Client
    belongs_to :stock, Stock

    timestamps()
  end

  @required_attrs ~w(stock_id client_id)a

  @doc false
  def changeset(subscription, attrs) do
    subscription
    |> cast(attrs, @required_attrs)
    |> validate_required(@required_attrs)
  end
end
