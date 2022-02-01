defmodule TimezoneConverter.DatetimeUtils do
	@moduledoc "Functions handling time"

  @typep timezone() :: String.t()
  @typep timezone_abbreviation() :: String.t()

  @spec get_tz_abbr(timezone()) :: timezone_abbreviation()
  def get_tz_abbr(tz_name) do
    %DateTime{zone_abbr: zone_abbr} = get_tz_datetime(tz_name, Time.utc_now())
  	zone_abbr
  end

  @spec get_time_in(timezone(), Time.t()) :: Time.t()
  def get_time_in(tz_name, time) do
  	get_tz_datetime(tz_name, time)
    |> DateTime.to_time()
    |> format_time()
  end

  @spec get_utc_time_now() :: Time.t()
  def get_utc_time_now() do
  	Time.utc_now()
  	|> format_time()
  end

  defp get_tz_datetime(tz_name, time) do
    NaiveDateTime.new!(Date.utc_today(), time)
    |> DateTime.from_naive!("Etc/UTC")
    |> DateTime.shift_zone!(tz_name)
  end

  defp format_time(time_utc) do
  	time_utc
  	|> Time.truncate(:second)
    |> Time.to_string()
  end
end
