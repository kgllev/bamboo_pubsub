# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :updates_consumer,
  ecto_repos: [UpdatesConsumer.Repo],
  generators: [binary_id: true]

# Configures the endpoint
config :updates_consumer, UpdatesConsumerWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: UpdatesConsumerWeb.ErrorHTML, json: UpdatesConsumerWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: UpdatesConsumer.PubSub,
  live_view: [signing_salt: "Y0DjI3Te"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :updates_consumer, UpdatesConsumer.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.1.8",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Company Updates Consumer Config
config :updates_consumer, UpdatesConsumer.Workers.CompanyEventsHandler,
  producer: [
    module:
      {BroadwayKafka.Producer,
       [
         hosts: [
           {System.get_env("EVENTS_KAFKA_URL", "pkc-6ojv2.us-west4.gcp.confluent.cloud"),
            System.get_env("EVENTS_KAFKA_PORT", "9092") |> String.to_integer()}
         ],
         group_id: System.get_env("EVENTS_KAFKA_GROUP_ID", "cnsumer"),
         topics: [
           System.get_env("EVENTS_KAFKA_TOPIC", "company-updates")
         ],
         receive_interval: 1000,
         client_config: [
           connect_timeout: 10_000,
           ssl: true,
           sasl: {
             :plain,
             System.get_env("KAFKA_KEY", "2FKXL5HKIIAWLV67"),
             System.get_env(
               "KAFKA_SECRET",
               "PxrLz7bwGVXZ5C6QrHD3fb6FUtfGph/Wq8h7jA11QNXZFMEtPW79WorlZ2IHF1wt"
             )
           }
         ]
       ]},
    concurrency: 10
  ],
  processors: [
    default: [
      concurrency: 4
    ]
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
