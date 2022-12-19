defmodule ProviderMock.KafkaProducer do
  @moduledoc """
  Send stock updates to kafka
  """
  @key "stock_updates"

  @doc """
  Send the message to the configured topic using the declared key
  """

  @spec produce(binary()) :: :ok
  def produce(message) do
    Kaffe.Producer.produce_sync(@key, message)
  end
end
