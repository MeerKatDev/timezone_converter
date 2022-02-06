defmodule TimezoneConverterWeb.TimeZoneLiveTest do
  use TimezoneConverterWeb.ConnCase, async: true
  use TimezoneConverter.LiveTestUtils

  defp land_on_page(%{conn: conn}) do
    {:ok, view, _html} = live(conn, Routes.timezone_path(conn, :index))
    %{view: view}
  end

  describe "on the timezone page" do
    setup [:land_on_page]

    test "using current time by default", %{view: view} do
      view
      |> element("#selected-time")
      |> assert_automatic_time()
    end

    test "by default, the chosen timezones flow normally", %{view: view} do
      view
      |> element("#selected-time")
      |> assert_automatic_time()

      view
      |> get_table_cells()
      |> Task.async_stream(&assert_automatic_time/1)
      |> Enum.reduce(nil, fn {:ok, {res1, res2}}, _ ->
        assert res1, "get utc time"
        assert res2, "get utc time after 1 second"
      end)
    end

    test "if the selected-time input is focused on, it switches to manual time", %{view: view} do
      view
      |> element("#selected-time")
      |> assert_manual_time()
    end

    test "in manual time, the chosen timezones are stopped as well", %{view: view} do
      view
      |> element("#selected-time")
      |> assert_manual_time()

      view
      |> get_table_cells()
      |> Task.async_stream(&assert_manual_time/1)
      |> Enum.reduce(nil, fn {:ok, {res1, res2}}, _ ->
        refute res1, "get utc time"
        refute res2, "get utc time after 1 second"
      end)
    end

    test "clicking on `use current time`, it goes back to current time", %{view: view} do
      sel_time_input = element(view, "#selected-time")
      curr_time_btn = element(view, "#btn-current-time")
      # first let's focus to go in manual time
      assert_manual_time(sel_time_input)
      # and then click on the button to go back to automatic time
      render_click(curr_time_btn)
      # aaaaand back to automatic time
      assert_automatic_time(sel_time_input)
    end
  end
end
