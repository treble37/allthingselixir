defmodule Allthingselixir.Event do
  use Allthingselixir.Web, :model
  alias Allthingselixir.Event

  schema "events" do
    field :name, :string
    has_many :locations, Allthingselixir.Location
    has_many :meta_properties, Allthingselixir.MetaProperty

    timestamps()
  end

  @required_fields ~w(name)

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name])
    |> validate_required(@required_fields)
  end

  def find_or_create_by_name(e_name, options \\ %{}) do
    query = from e in Event, where: e.name == ^e_name
    if !Repo.one(query) do
      Event.changeset(%Event{}, Map.merge(%{name: e_name}, options))
      |> Repo.insert!
    end
    Repo.one(query)
  end
end
