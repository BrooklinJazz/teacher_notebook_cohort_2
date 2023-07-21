defmodule CounterWeb.CountController do
  use CounterWeb, :controller

  def count(conn, %{"count" => count} = params) do
    IO.inspect(params, label: "QUERY PARAMS")
    render(conn, :count, greeting: "hello", count: String.to_integer(count))
  end

  def count(conn, _params) do
    render(conn, :count, count: 0)
  end

  def increment(conn, %{"increment" => increment, "count" => count} = params) do
    IO.inspect(params)
    render(conn, :count, count: String.to_integer(increment) + String.to_integer(count))
  end
end
