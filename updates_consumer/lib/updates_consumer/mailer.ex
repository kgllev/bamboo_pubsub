defmodule UpdatesConsumer.Mailer do
  use Swoosh.Mailer, otp_app: :updates_consumer

  def send_stock_updates(subscriber) do
  end

  def stock_update_email(client, stock) do
    # client
    # |> base_email()
    # |> from({@sender_name, "update@bambooinvestment.com"})
    # |> subject("Please confirm your email")
    # |> assign(:user, user)
    # |> assign(:url, url)
    # |> render(:confirmation_instructions)
  end
end
