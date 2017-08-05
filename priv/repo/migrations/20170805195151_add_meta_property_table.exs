defmodule Allthingselixir.Repo.Migrations.AddMetaPropertyTable do
  use Ecto.Migration

  def change do
    create table(:meta_properties) do
      add :twitter, :string
      add :url, :string
      add :time_zone, :string
      add :start_date, :date
      add :end_date, :date
      add :cfp_closing_datetime, :timestamp
      add :event_id, references(:events, on_delete: :nothing)

      timestamps()
    end

    alter table(:events) do
      remove :twitter
      remove :url
      remove :start_date
      remove :end_date
      remove :cfp_closing_datetime
    end
  end
end
