defmodule Allthingselixir.EventWorker do
  alias Allthingselixir.Event
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_work() #Schedule work to be performed at some point
    {:ok, state}
  end

  def handle_info(:work, state) do
    current_year = (Calendar.DateTime.now! "UTC").year
    data = File.cwd!
           |> Path.join("web/data/#{current_year}_conferences.yml")
           |> YamlElixir.read_from_file
           |> process_event_data_from_yaml
    schedule_work()
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 24 * 60 * 60 * 1000) #  Every 24 hours
  end

  defp process_event_data_from_yaml(data) do
#   [%{"cfp_closing_datetime" => "05/28/2017 11:59 PM", "end_date" => "09/08/2017",
#   "location" => %{"city" => "Bellvue", "country" => "United States of America",
#     "postal_code" => 98004, "state" => "Washington",
#     "street_address" => "900 Bellvue Way NE"}, "name" => "ElixirConf",
#   "start_date" => "09/05/2017", "time_zone" => "PST",
#   "twitter" => "ElixirConf", "url" => "https://elixirconf.com/"}]
    data
    |> Enum.each(fn(opts) -> Event.find_or_create_by_name(opts["name"], Map.drop(opts, ["location", "name", "start_date", "end_date", "time_zone", "cfp_closing_datetime"])) end)
  end
end
