defmodule TimezoneConverter.TimerUtils do
  @moduledoc """
  Functions handling erlang timer
  They raise and restart if something with the timer goes wrong
  """
  @interval 100

  @typep socket() :: %Phoenix.LiveView.Socket{}

  @spec set_time_interval(socket(), boolean(), pid()) :: socket()
  def set_time_interval(socket, connected?, pid) do
    if connected? do
      {:ok, timer_ref} = :timer.send_interval(@interval, pid, :tick)
      %{socket | assigns: Map.put(socket.assigns, :timer_ref, timer_ref)}
    else
      socket
    end
  end

  @spec unset_time_interval(socket(), boolean()) :: socket()
  def unset_time_interval(%{assigns: assigns} = socket, connected?) do
    if connected? do
      {:ok, :cancel} = :timer.cancel(assigns.timer_ref)
      %{socket | assigns: Map.delete(assigns, :timer_ref)}
    else
      socket
    end
  end
end
