defmodule UpdatesConsumer.Repo.Migrations.CreateStocks do
  use Ecto.Migration

  def change do
    create table(:stocks, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :symbol, :string
      add :price, :decimal

      timestamps()
    end

    create unique_index(:stocks, [:symbol])
  end
end
