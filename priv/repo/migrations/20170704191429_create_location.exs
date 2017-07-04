defmodule Allthingselixir.Repo.Migrations.CreateLocation do
  use Ecto.Migration

  def change do
    create table(:locations) do
      add :city, :string
      add :state, :string
      add :country, :string
      add :postal_code, :string
      add :street_address, :string
      add :latitude, :string
      add :longitude, :string
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end
    create index(:locations, [:event_id])

  end
end
