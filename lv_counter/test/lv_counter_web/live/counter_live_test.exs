defmodule LvCounterWeb.CounterLiveTest do
  use LvCounterWeb.ConnCase
  import Phoenix.LiveViewTest

  test "mount/3", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")

    assert view |> element("#count") |> render() =~ "0"
  end

  test "increment button", %{conn: conn} do
  	{:ok, view, html} = live(conn, "/")
  	view |> element("#increment-button") |> render_click() #action
		assert view |> element("#count") |> render() =~ "1"
  end

  test "increment form", %{conn: conn} do
    {:ok, view, _html} = live(conn, "/")
  	view |> element("#increment-form") |> render_submit(%{increment_by: 4})
		assert view |> element("#count") |> render() =~ "4"
  end
end
