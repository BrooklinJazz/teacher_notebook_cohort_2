defmodule PicChat.SummaryEmail do
  alias Swoosh.Email

  def send_to_subscribers do
    messages = PicChat.Messages.todays_messages()
               |> Enum.map_join("<br/>", fn message -> message_to_html(message) end)


    Enum.each(PicChat.Accounts.subscribed_emails(), fn subscribed ->
      PicChat.Mailer.deliver(build(subscribed, messages))
    end)
  end

  defp build(subscribed, messages) do
    Email.new()
    |> Email.to(subscribed)
    |> Email.from("test@test.test")
    |> Email.html_body(messages)
    |> Email.subject("today's emails")
    # |> Email.text_body(messages)
  end

  def message_to_html(message) do
   """
    <p>#{message.content}</p>
    <p>#{message.picture}</p>
   """
  end

end
