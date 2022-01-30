defmodule TimezoneConverterWeb.PageController do
  use TimezoneConverterWeb, :controller
  alias TimezoneConverter.Models.TimeZone, as: TZ

  def index(conn, _params) do
    render(conn, "index.html", timezones: TZ.all())
  end

  @type timezone() :: String.t()

  @spec get_time_in(timezone()) :: Time.t()
  defp get_time_in(timezone) do
    NaiveDateTime.utc_now()
    |> DateTime.from_naive!("Etc/UTC")
    |> DateTime.shift_zone!(timezone)
    |> DateTime.to_time()
  end
end
