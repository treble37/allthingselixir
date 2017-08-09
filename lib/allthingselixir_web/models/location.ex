defmodule Allthingselixir.Location do
  use Allthingselixir.Web, :model
  alias Allthingselixir.Location

  schema "locations" do
    field :city, :string
    field :state, :string
    field :country, :string
    field :postal_code, :string
    field :street_address, :string
    field :latitude, :string
    field :longitude, :string
    belongs_to :event, Allthingselixir.Event

    timestamps()
  end

  @required_fields ~w(city country event_id)a
  @optional_fields ~w(state postal_code street_address latitude longitude)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:city, :state, :country, :postal_code, :street_address, :latitude, :longitude])
    |> validate_required(@required_fields)
  end

  def find_or_create_by_city_country(nil, _options), do: nil
  def find_or_create_by_city_country(event, options) do
    location_changeset = event
                         |> build_assoc(:locations)
                         |> Location.changeset(options)
    location = Repo.get_by(Location, event_id: event.id)
    if !location && location_changeset.valid? do
      location_changeset
      |> Repo.insert!
    else
      location
    end
  end
end
