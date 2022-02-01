defmodule TimezoneConverterWeb.PageController do
  use TimezoneConverterWeb, :controller
  alias TimezoneConverter.Models.TimeZone, as: TZ

  def index(conn, _params) do
    render(conn, "index.html", timezones: TZ.all())
  end
end
