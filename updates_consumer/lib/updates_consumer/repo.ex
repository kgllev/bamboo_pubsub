defmodule UpdatesConsumer.Repo do
  use Ecto.Repo,
    otp_app: :updates_consumer,
    adapter: Ecto.Adapters.Postgres
end
