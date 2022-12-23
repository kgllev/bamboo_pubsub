## Getting started

Clone the repo

```
git@github.com:kgllev/bamboo_pubsub.git
```

Install Elixir version `1.14.2` and Erlang version `25.0`

On the root folder(bamboo_assignment), open terminal to start the mock provider

```
cd provider_mock && mix deps.get && mix compile && iex -S mix
```

This will publish the mock data events to kafka on confluence

Open another terminal from the root folder and run 

```
cd updates_consumer && mix setup && iex -S mix phx.server
```

This will start the updates_consumer responsible for consuming events published by the provider_mock, create tables and seed initial data

## Testing

```
cd updates_consumer && mix setup && mix test
```
