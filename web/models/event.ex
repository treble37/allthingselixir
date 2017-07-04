defmodule Allthingselixir.Event do
  use Allthingselixir.Web, :model

  schema "events" do
    field :name, :string
    field :twitter, :string
    field :url, :string
    field :start_date, Ecto.Date
    field :end_date, Ecto.Date
    field :cfp_closing_date, Ecto.Date

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :twitter, :url, :start_date, :end_date, :cfp_closing_date])
    |> validate_required([:name, :twitter, :url, :start_date, :end_date, :cfp_closing_date])
  end
end
