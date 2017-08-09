defmodule Allthingselixir.EventWorker do
  alias Allthingselixir.YamlReader

  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() #Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    schedule_work()
    YamlReader.read_file
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 1000)#24 * 60 * 60 * 1000) #  Every 24 hours
  end
end
