defmodule TimezoneConverterWeb.TimeZoneLiveTest do
  use TimezoneConverterWeb.ConnCase

  import Phoenix.LiveViewTest
  import TimezoneConverter.ModelsFixtures

  @create_attrs %{name: "some name"}
  @update_attrs %{name: "some updated name"}
  @invalid_attrs %{name: nil}

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

    test "saves new time_zone", %{conn: conn} do
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

    test "updates time_zone in listing", %{conn: conn, time_zone: time_zone} do
      {:ok, index_live, _html} = live(conn, Routes.time_zone_index_path(conn, :index))

      assert index_live |> element("#time_zone-#{time_zone.id} a", "Edit") |> render_click() =~
               "Edit Time zone"

      assert_patch(index_live, Routes.time_zone_index_path(conn, :edit, time_zone))

      assert index_live
             |> form("#time_zone-form", time_zone: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        index_live
        |> form("#time_zone-form", time_zone: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.time_zone_index_path(conn, :index))

      assert html =~ "Time zone updated successfully"
      assert html =~ "some updated name"
    end

    test "deletes time_zone in listing", %{conn: conn, time_zone: time_zone} do
      {:ok, index_live, _html} = live(conn, Routes.time_zone_index_path(conn, :index))

      assert index_live |> element("#time_zone-#{time_zone.id} a", "Delete") |> render_click()
      refute has_element?(index_live, "#time_zone-#{time_zone.id}")
    end
  end

  describe "Show" do
    setup [:create_time_zone]

    test "displays time_zone", %{conn: conn, time_zone: time_zone} do
      {:ok, _show_live, html} = live(conn, Routes.time_zone_show_path(conn, :show, time_zone))

      assert html =~ "Show Time zone"
      assert html =~ time_zone.name
    end

    test "updates time_zone within modal", %{conn: conn, time_zone: time_zone} do
      {:ok, show_live, _html} = live(conn, Routes.time_zone_show_path(conn, :show, time_zone))

      assert show_live |> element("a", "Edit") |> render_click() =~
               "Edit Time zone"

      assert_patch(show_live, Routes.time_zone_show_path(conn, :edit, time_zone))

      assert show_live
             |> form("#time_zone-form", time_zone: @invalid_attrs)
             |> render_change() =~ "can&#39;t be blank"

      {:ok, _, html} =
        show_live
        |> form("#time_zone-form", time_zone: @update_attrs)
        |> render_submit()
        |> follow_redirect(conn, Routes.time_zone_show_path(conn, :show, time_zone))

      assert html =~ "Time zone updated successfully"
      assert html =~ "some updated name"
    end
  end
end
