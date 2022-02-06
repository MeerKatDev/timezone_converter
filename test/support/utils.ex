defmodule TimezoneConverter.LiveTestUtils do
  use ExUnit.CaseTemplate

  using do
    quote do
  import TimezoneConverter.DatetimeUtils
  import Phoenix.LiveViewTest
  import TimezoneConverter.LiveTestUtils

  defp assert_automatic_time({tz_el, time_el}) do
    tz_name = take_text_from_td(tz_el)
    res1 = render(time_el) =~ get_time_in(tz_name, get_utc_time_now_obj())
    Process.sleep(1000)
    res2 = render(time_el) =~ get_time_in(tz_name, get_utc_time_now_obj())
    {res1, res2}
  end

  defp assert_automatic_time(el) do
    assert render(el) =~ get_utc_time_now()
    Process.sleep(1000)
    assert render(el) =~ get_utc_time_now()
  end

  defp assert_manual_time({tz_el, time_el}) do
    tz_name = take_text_from_td(tz_el)
    res1 = render(time_el) =~ get_time_in(tz_name, get_utc_time_now_obj())
    Process.sleep(1000)
    res2 = render(time_el) =~ get_time_in(tz_name, get_utc_time_now_obj())
    {res1, res2}
  end

  defp assert_manual_time(el) do
    # this should stop the flow of time
    assert render_focus(el) =~ get_utc_time_now()
    Process.sleep(1000)
    # it stopped flowing, so it's in manual time
    refute render(el) =~ get_utc_time_now()
  end

  defp take_text_from_td(el) do
    [[_, text]] = Regex.scan(~r"<td>(.*?)</td>", render(el))
    text
  end

  def get_table_cells(view) do
    Enum.map(
      1..3,
      &{element(view, "tr:nth-child(#{&1}) > td:nth-child(1)"),
       element(view, "tr:nth-child(#{&1}) > td:nth-child(2)")}
    )
  end
  	end
  end
end
