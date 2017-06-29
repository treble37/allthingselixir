defmodule Allthingselixir.PageController do
  use Allthingselixir.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
