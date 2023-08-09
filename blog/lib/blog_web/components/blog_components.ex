defmodule BlogWeb.BlogComponents do
  use Phoenix.Component

  slot :inner_block, required: true

  def my_list(assigns) do
    ~H"""
    <ul class="bg-red-400">
      <%= render_slot(@inner_block) %>
    </ul>
    """
  end
end
