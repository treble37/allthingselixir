defmodule Allthingselixir.Event do
  use Allthingselixir.Web, :model
  alias Allthingselixir.Event

  schema "events" do
    field :name, :string
    field :twitter, :string
    field :url, :string
    field :start_date, Ecto.Date
    field :end_date, Ecto.Date
    field :cfp_closing_datetime, Ecto.DateTime

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :twitter, :url, :start_date, :end_date, :cfp_closing_datetime])
    |> validate_required([:name])
  end

  def find_or_create_by_name(e_name, options \\ %{}) do
    query = from e in Event, where: e.name == ^e_name
    if !Repo.one(query) do
      Event.changeset(%Event{}, Map.merge(%{"name" => e_name}, options))
      |> Repo.insert!
    end
    Repo.one(query)
  end
end
