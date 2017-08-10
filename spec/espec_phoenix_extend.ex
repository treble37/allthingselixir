defmodule ESpec.Phoenix.Extend do
  def model do
    quote do
      alias Allthingselixir.Repo
    end
  end

  def controller do
    quote do
      alias Allthingselixir
      import Allthingselixir.Router.Helpers

      @endpoint Allthingselixir.Endpoint
    end
  end

  def view do
    quote do
      import Allthingselixir.Router.Helpers
    end
  end

  def channel do
    quote do
      alias Allthingselixir.Repo

      @endpoint Allthingselixir.Endpoint
    end
  end

  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
