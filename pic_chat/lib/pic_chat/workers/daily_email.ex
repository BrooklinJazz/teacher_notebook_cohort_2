defmodule PicChat.Workers.DailyEmail do
  alias PicChat.SummaryEmail
  use Oban.Worker, queue: :default, max_attempts: 1

  @impl true
  def perform(_params) do
    IO.inspect("I ran")
    SummaryEmail.send_to_subscribers()
    :ok
  end
end
