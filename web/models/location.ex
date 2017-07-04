defmodule Allthingselixir.Location do
  use Allthingselixir.Web, :model

  schema "locations" do
    field :city, :string
    field :state, :string
    field :country, :string
    field :postal_code, :string
    field :street_name, :string
    field :street_number, :string
    field :latitude, :string
    field :longitude, :string
    belongs_to :event, Allthingselixir.Event

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:city, :state, :country, :postal_code, :street_name, :street_number, :latitude, :longitude])
    |> validate_required([:city, :state, :country, :postal_code, :street_name, :street_number, :latitude, :longitude])
  end
end
