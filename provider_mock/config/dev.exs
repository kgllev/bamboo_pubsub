import Config

config :provider_mock, ProviderMock.Client.SocketSubscriber,
  ws_url: System.get_env("CLIENT_WS_URL", "wss://stream.data.alpaca.markets/v1beta1/crypto"),
  auth_params: [
    action: "auth",
    action: System.get_env("WS_CLIENT_AUTH_ACTION_ID", "auth"),
    key: System.get_env("WS_CLIENT_KEY", "AKKV8AMOCN4EMYVRPSV4"),
    secret: System.get_env("WS_CLIENT_SECRET", "RotPj7AQSZBkQs5OrsFgAQcZgImYkZiEDca6L67X")
  ]

config :kaffe,
  producer: [
    endpoints: ["pkc-6ojv2.us-west4.gcp.confluent.cloud": 9092],
    topics: ["company-updates"],
    partition_strategy: :md5,
    ssl: true,
    sasl: %{
      mechanism: :plain,
      login: System.get_env("KAFFE_PRODUCER_USER", "2FKXL5HKIIAWLV67"),
      password:
        System.get_env(
          "KAFFE_PRODUCER_PASSWORD",
          "PxrLz7bwGVXZ5C6QrHD3fb6FUtfGph/Wq8h7jA11QNXZFMEtPW79WorlZ2IHF1wt"
        )
    }
  ]
