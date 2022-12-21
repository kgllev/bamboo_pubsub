defmodule UpdatesConsumer.Accounts.Client do
  @moduledoc """
  Clients Schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  alias UpdatesConsumer.Accounts.Subscription

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "clients" do
    field :name, :string
    has_many :subscriptions, Subscription

    timestamps()
  end

  @doc false
  def changeset(client, attrs) do
    client
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
