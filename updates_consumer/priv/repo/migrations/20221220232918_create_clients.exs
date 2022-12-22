defmodule UpdatesConsumer.Repo.Migrations.CreateClients do
  use Ecto.Migration

  def change do
    create table(:clients, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :email, :string

      timestamps()
    end
  end
end
