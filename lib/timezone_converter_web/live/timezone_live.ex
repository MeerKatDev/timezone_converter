defmodule TimezoneConverterWeb.Live.TimezoneLive do
	use TimezoneConverterWeb, :live_view
  alias TimezoneConverter.Models.TimeZone, as: TZ
  import TimezoneConverter.DatetimeUtils
  import TimezoneConverter.TimerUtils

	def mount(_params, _session, socket) do
		socket
		|> set_time_interval(connected?(socket), self())
		|> assign(use_current_time: true)
		|> assign(timezones: TZ.all())
		|> (&selected(:fetch, &1)).()
		|> (&{:ok, &1}).()
	end

	def handle_event("add", %{"timezone" => %{"timezone_name" => timezone_name}}, socket) do
		case TZ.update_selected(timezone_name, true) do
  		{:ok, _} ->
  			put_flash(socket, :info, "Timezone added to list successfully")
			{:error, err} ->
				put_flash(socket, :error, inspect(err))
		end
		|> (&{:noreply, selected(:fetch, &1)}).()
	end

	def handle_event("unselect", %{"ref" => timezone_name}, socket) do
		case TZ.update_selected(timezone_name, false) do
  		{:ok, _} ->
  			put_flash(socket, :info, "Timezone removed from list successfully")
			{:error, err} ->
				put_flash(socket, :error, inspect(err))
		end
		|> (&{:noreply, selected(:fetch, &1)}).()
	end

	def handle_event("use_current_time", _, socket) do
		if(!socket.assigns.use_current_time) do
			socket
			|> set_time_interval(connected?(socket), self())
			|> assign(use_current_time: true)
			|> assign(current_time: get_utc_time_now())
			|> (&{:noreply, selected(:fetch, &1)}).()
		else
			{:noreply, put_flash(socket, :info, "Already using current time")}
		end
	end

	def handle_event("set_manual_time", %{"value" => current_time}, socket) do # on-focus
		if(socket.assigns.use_current_time) do
			socket
			|> unset_time_interval(connected?(socket))
			|> assign(use_current_time: false)
			|> assign(current_time: current_time)
			|> (&{:noreply, selected(:fetch, &1)}).()
		else
			{:noreply, socket}
		end
	end

	def handle_event("update_manual_time", %{"time" => %{"selected_time" => current_time}}, socket) do
		if(!socket.assigns.use_current_time && byte_size(current_time) == 8 ) do
			socket
			|> assign(current_time: current_time)
			|> (&{:noreply, selected(:update, &1, current_time)}).()
		else
			{:noreply, socket}
		end
	end

	def handle_event(unhandled_event, data_received, socket) do
		IO.inspect unhandled_event, label: "Unhandled event"
		IO.inspect data_received, label: "Data received"
		{:noreply, socket}
	end

	def handle_info(:tick, socket) do
    {:noreply, selected(:update, socket)}
	end

	defp selected(_, _, time \\ get_utc_time_now())

	defp selected(:update, %{assigns: assigns} = socket, time) do
		socket
		|> update_selected(assigns.selected_tzs, time)
		|> assign(current_time: time)
	end

	defp selected(:fetch, socket, time) do
		current_time = Map.get(socket.assigns, :current_time, get_utc_time_now())

		socket
		|> update_selected(TZ.all_selected(), get_utc_time_now())
		|> assign(current_time: current_time)
	end

	defp update_selected(socket, selected_tzs, time) do
		complete_tzs = Enum.map(selected_tzs, fn %{name: name} ->
			%{name: name, abbr: get_tz_abbr(name), time: get_time_in(name, Time.from_iso8601!(time))}
		end)

		assign(socket, selected_tzs: complete_tzs)
	end

end