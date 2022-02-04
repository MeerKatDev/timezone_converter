defmodule TimezoneConverterWeb.TimeZoneLiveTest do
  use TimezoneConverterWeb.ConnCase

  import Phoenix.LiveViewTest

  defp create_time_zone(_) do
    time_zone = time_zone_fixture()
    %{time_zone: time_zone}
  end

  describe "Index" do
    setup [:create_time_zone]

    test "lists all time_zones", %{conn: conn, time_zone: time_zone} do
      {:ok, _index_live, html} = live(conn, Routes.time_zone_index_path(conn, :index))

      assert html =~ "Listing Time zones"
      assert html =~ time_zone.name
    end

      {:ok, index_live, _html} = live(conn, Routes.time_zone_index_path(conn, :index))

      assert index_live |> element("a", "New Time zone") |> render_click() =~
               "New Time zone"

      assert_patch(index_live, Routes.time_zone_index_path(conn, :new))

      assert index_live
             |> form("#time_zone-form", time_zone: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#time_zone-form", time_zone: @create_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.time_zone_index_path(conn, :index))

      assert html =~ "Time zone created successfully"
      assert html =~ "some name"
    end
end