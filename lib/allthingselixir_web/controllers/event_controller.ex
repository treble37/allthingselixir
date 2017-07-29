defmodule Allthingselixir.Web.EventController do
  use Allthingselixir.Web, :controller
  import QueryHelper

  def index(conn, _params) do
    render conn, "index.html", events: event_query
  end
end
