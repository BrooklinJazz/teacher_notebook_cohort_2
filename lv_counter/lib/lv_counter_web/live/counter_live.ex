defmodule LvCounterWeb.CounterLive do
  use LvCounterWeb, :live_view

  def mount(_params, _session, socket) do
    if connected?(socket) do
      # Process.send_after(self(), :increment, 1_000)
    end

    {:ok, assign(socket, count: 0, form: to_form(%{"increment_by" => ""}))}
  end

  def render(assigns) do
    ~H"""
    <h1>Hello</h1>
    <p id="count"><%= @count %></p>
    <.button id="increment-button" phx-click="increment">Increment</.button>
    <.button phx-click="async_increment">Async Increment</.button>

    <.simple_form id="increment-form" for={@form} phx-submit="increment_by">
      <.input field={@form[:increment_by]} type="number" label="Increment by" />
      <:actions>
        <.button>+</.button>
      </:actions>
    </.simple_form>
    """
  end

  def handle_event("async_increment", _params, socket) do
    parent = self()

    Task.start(fn ->
      Process.sleep(1000)
      send(parent, :increment)
    end)

    {:noreply, socket}
  end

  def handle_event("increment", _params, socket) do
    count = socket.assigns.count + 1
    {:noreply, assign(socket, :count, count)}
  end

  def handle_event("increment_by", %{"increment_by" => num}, socket) do
    socket =
      case Integer.parse(num) do
        {int, _} ->
          assign(socket,
            count: socket.assigns.count + int,
            form: to_form(%{"increment_by" => num})
          )

        :error ->
          assign(socket,
            form:
              to_form(%{"increment_by" => num},
                errors: [increment_by: {"Must be an integer.", []}]
              )
          )
      end

    {:noreply, socket}
  end

  def handle_info(:increment, socket) do
    {:noreply, assign(socket, count: socket.assigns.count + 1)}
  end
end
