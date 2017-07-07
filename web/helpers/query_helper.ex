defmodule QueryHelper do
  alias Allthingselixir.{Repo, Event}

  import Ecto
  import Ecto.Query

  def event_query do
    query = from e in Event
    Repo.all(query)
  end
end
