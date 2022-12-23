defmodule UpdatesConsumer.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias UpdatesConsumer.Repo
  alias UpdatesConsumer.Accounts.Client
  alias UpdatesConsumer.Accounts.Subscription

  @doc """
  Creates a client.
  ## Examples
      iex> create_client(%{field: value})
      {:ok, %Client{}}
      iex> create_client(%{field: bad_value})
      {:error, %Ecto.Changeset{}}
  """
  @spec create_client(map()) :: {:ok, Client.t()} | {:error, Changeset.t()}
  def create_client(attrs \\ %{}) do
    %Client{}
    |> Client.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Returns the list of subscriptions with clients.

  ## Examples

      iex> list_subscriptions(stock_id)
      [%Subscription{}, ...]

  """
  @spec list_subscriptions(String.t()) :: list() | nil
  def list_subscriptions(stock_id) do
    Subscription
    |> where([s], s.stock_id == ^stock_id)
    |> Repo.all()
    |> Repo.preload(:client)
  end

  @doc """
  Creates a subscription.

  ## Examples

      iex> create_subscription(%{field: value})
      {:ok, %Subscription{}}

      iex> create_subscription(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  @spec create_subscription(map()) :: {:ok, Subscription.t()} | {:error, Changeset.t()}
  def create_subscription(attrs \\ %{}) do
    %Subscription{}
    |> Subscription.changeset(attrs)
    |> Repo.insert()
  end
end
