defmodule UpdatesConsumer.Repo.Migrations.CreateSubscriptions do
  use Ecto.Migration

  def change do
    create table(:subscriptions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :client_id, references(:clients, on_delete: :delete_all, type: :binary_id), null: false
      add :stock_id, references(:stocks, on_delete: :delete_all, type: :binary_id), null: false

      timestamps()
    end

    create unique_index(:subscriptions, [:stock_id, :client_id])
  end
end
