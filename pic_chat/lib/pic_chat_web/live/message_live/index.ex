defmodule PicChatWeb.MessageLive.Index do
  use PicChatWeb, :live_view

  alias PicChat.Messages
  alias PicChat.Messages.Message

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      PicChatWeb.Endpoint.subscribe("chat:1")
    end

    {:ok, stream(socket, :messages, Messages.list_messages())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Message")
    |> assign(:message, Messages.get_message!(id))
  end

  defp apply_action(socket, :new, _params) do
    if socket.assigns[:current_user] do
      socket
      |> assign(:page_title, "New Message")
      |> assign(:message, %Message{})
    else
      socket |> redirect(to: ~p"/users/log_in")
    end
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Messages")
    |> assign(:message, nil)
  end

  @impl true
  def handle_info({PicChatWeb.MessageLive.FormComponent, {:saved, message}}, socket) do
    {:noreply, stream_insert(socket, :messages, message, at: 0)}
  end

  def handle_info(%Phoenix.Socket.Broadcast{topic: "chat:1", event: "new_message", payload: message}, socket) do
    {:noreply, stream_insert(socket, :messages, message, at: 0)}
  end

  def handle_info(%Phoenix.Socket.Broadcast{topic: "chat:1", event: "edit_message", payload: message}, socket) do
    {:noreply, stream_insert(socket, :messages, message, at: 0)}
  end

  def handle_info(%Phoenix.Socket.Broadcast{topic: "chat:1", event: "delete_message", payload: message}, socket) do
    {:noreply, stream_delete(socket, :messages, message)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    message = Messages.get_message!(id)
    if message.user_id == socket.assigns.current_user.id do
      {:ok, _} = Messages.delete_message(message)
      PicChatWeb.Endpoint.broadcast_from!(self(), "chat:1", "delete_message", message)
      {:noreply, stream_delete(socket, :messages, message)}
    else
      {:noreply, socket}
    end
  end
end
