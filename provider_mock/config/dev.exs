import Config

config :provider_mock, ProviderMock.Client.SocketSubscriber,
  ws_url: System.get_env("CLIENT_WS_URL", "wss://stream.data.alpaca.markets/v1beta1/crypto"),
  auth_params: [
    action: "auth",
    action: System.get_env("WS_CLIENT_AUTH_ACTION_ID", "auth"),
    key: System.get_env("WS_CLIENT_KEY", "AKKV8AMOCN4EMYVRPSV4"),
    secret: System.get_env("WS_CLIENT_SECRET", "RotPj7AQSZBkQs5OrsFgAQcZgImYkZiEDca6L67X")
  ]
