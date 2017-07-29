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
    current_year = Timex.now.year
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
    |> Enum.map(fn(map) -> process_map_with_dates(map) end)
    |> Enum.each(fn(opts) -> Event.find_or_create_by_name(opts["name"], Map.drop(opts, ["name"])) end)
  end

  def process_map_with_dates(map) do
    %{"cfp_closing_datetime" => cfp_closing_datetime,
      "start_date" => start_date, "end_date" => end_date } = map
    Map.merge(map, %{"cfp_closing_datetime" => transform_datetime(cfp_closing_datetime),
      "start_date" => transform_date(start_date),
      "end_date" => transform_date(end_date)}
    )
  end

  def transform_datetime(input) do
    # {:ok, ~N[2016-09-05 23:59:00]}
    {status, datetime} = Timex.parse(input, "%m/%d/%Y %I:%M %p", :strftime)
    transform_datetime(status, datetime, input)
  end

  def transform_datetime(:error, datetime_str, original_input), do: original_input
  def transform_datetime(:ok, datetime_str, original_input), do: datetime_str

  def transform_date(input) do
    {status, date} = Timex.parse(input, "{0M}/{0D}/{YYYY}")
    transform_date(status, date, input)
  end

  def transform_date(:error, date_str, original_input), do: original_input
  def transform_date(:ok, date_str, original_input), do: date_str
end
