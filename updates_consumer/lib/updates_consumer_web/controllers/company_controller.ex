defmodule UpdatesConsumerWeb.CompanyController do
  use UpdatesConsumerWeb, :controller

  alias UpdatesConsumer.Companies

  action_fallback UpdatesConsumerWeb.FallbackController

  def index(conn, _params) do
    companies = Companies.list_stocks()
    render(conn, :index, companies: companies)
  end
end
