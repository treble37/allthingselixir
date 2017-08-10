defmodule Allthingslelixir.Factories do
  use ExMachina.Ecto, repo: Allthingslelixir.Repo

  def event_factory do
    %Allthingselixir.Event{
      name: "Awesome Conference",
      locations: [build(:location)],
      meta_properties: [build(:meta_property)]
    }
  end

  def location_factory do
    %Allthingselixir.Location{
      city: "Seattle",
      state: "Washington",
      country: "United States of America",
      postal_code: "98004",
      street_address: "900 Bellvue Way NE",
      latitude: 47.6,
      longitude: -122.33,
      event: build(:event)
    }
  end

  def meta_property_factory do
    %Allthingselixir.MetaProperty{
      twitter: "ElixirConf",
      url: "https://elixirconf.com/",
      #start_date: Ecto.Date.cast!(~D[09-07-2017]),
      #end_date: Ecto.Date.cast!(~D[09-08-2017]),
      cfp_closing_datetime: DateTime.from_iso8601("2017-04-23T23:50:07Z"),
      event: build(:event)
    }
  end
end
