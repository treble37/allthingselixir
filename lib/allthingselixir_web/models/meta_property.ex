defmodule Allthingselixir.MetaProperty do
  use Allthingselixir.Web, :model
  alias Allthingselixir.MetaProperty

  schema "meta_properties" do
    field :twitter, :string
    field :url, :string
    field :start_date, Ecto.Date
    field :end_date, Ecto.Date
    field :cfp_closing_datetime, Ecto.DateTime
    belongs_to :event, Allthingselixir.Event

    timestamps()
  end

  @required_fields ~w(end_date event_id)a
  @optional_fields ~w(twitter url start_date end_date cfp_closing_datetime)a

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, @optional_fields)
    |> validate_required(@required_fields)
  end

  def find_or_create_by_end_date(nil, _options), do: nil
  def find_or_create_by_end_date(event, options) do
    meta_property_changeset = event
                              |> build_assoc(:meta_properties)
                              |> MetaProperty.changeset(options)
    meta_property = Repo.get_by(MetaProperty, event_id: event.id)
    if !meta_property && meta_property_changeset.valid? do
      meta_property_changeset
      |> Repo.insert!
    else
      meta_property
    end
  end
end
