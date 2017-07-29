defmodule Allthingselixir.User do
  use Allthingselixir.Web, :model

  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :email, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:first_name, :last_name, :email])
    |> validate_required([:first_name, :last_name, :email])
  end
end
