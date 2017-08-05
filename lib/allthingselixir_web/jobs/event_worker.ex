defmodule Allthingselixir.EventWorker do
  alias Allthingselixir.{Event, Location, MetaProperty}
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
           |> Path.join("lib/allthingselixir_web/data/#{current_year}_conferences.yml")
           |> YamlElixir.read_from_file(atoms: true)
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
    |> Enum.map(&process_map_with_dates/1)
    |> Enum.each(&find_or_create_models/1)
  end

  def find_or_create_models(opts) do
    event = Event.find_or_create_by_name(opts["name"], %{})
    Location.find_or_create_by_city_country(event, opts["location"])
    MetaProperty.find_or_create_by_end_date(event, Map.take(opts, ["twitter", "url", "start_date", "end_date", "time_zone", "cfp_closing_datetime"]))
  end

  def process_map_with_dates(map) do
    %{"cfp_closing_datetime" => cfp_closing_datetime,
      "start_date" => start_date, "end_date" => end_date } = map
    %{"location" => loc_map} = map

    m=Map.merge(map, %{"cfp_closing_datetime" => transform_datetime(cfp_closing_datetime),
      "start_date" => transform_date(start_date),
      "end_date" => transform_date(end_date),
      "location" => Map.merge(loc_map, %{"postal_code" => stringify_field(loc_map, "postal_code")}) }
    )
    IO.inspect m
    m
  end

  def stringify_field(map, field) do
    stringify_field(map[field])
  end

  def stringify_field(nil), do: ""
  def stringify_field(val) when is_binary(val), do: val
  def stringify_field(val) when is_number(val), do: val |> to_string

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
