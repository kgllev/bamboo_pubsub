alias UpdatesConsumer.Accounts
alias UpdatesConsumer.Companies

# Create clients

{:ok, %{id: client_1}} = Accounts.create_client(%{email: "client_1@bambooinvestments.com"})
{:ok, %{id: client_2}} = Accounts.create_client(%{email: "client_2@bambooinvestments.com"})
{:ok, %{id: client_3}} = Accounts.create_client(%{email: "client_3@bambooinvestments.com"})

# Create Company Stocks

{:ok, %{id: stock_1}} = Companies.create_stock(%{symbol: "BTCUSD", price: 16807.11})
{:ok, %{id: stock_2}} = Companies.create_stock(%{symbol: "ETH", price: 291.07})
{:ok, %{id: stock_3}} = Companies.create_stock(%{symbol: "USDT", price: 1822.13})

## Create Client Subscriptions

Accounts.create_subscription(%{client_id: client_1, stock_id: stock_1})
Accounts.create_subscription(%{client_id: client_2, stock_id: stock_2})
Accounts.create_subscription(%{client_id: client_3, stock_id: stock_3})
