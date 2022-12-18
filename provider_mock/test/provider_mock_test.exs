defmodule ProviderMockTest do
  use ExUnit.Case
  doctest ProviderMock

  test "greets the world" do
    assert ProviderMock.hello() == :world
  end
end
