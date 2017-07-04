defmodule Allthingselixir.LocationTest do
  use Allthingselixir.ModelCase

  alias Allthingselixir.Location

  @valid_attrs %{city: "some content", country: "some content", latitude: "some content", longitude: "some content", postal_code: "some content", state: "some content", street_name: "some content", street_number: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Location.changeset(%Location{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Location.changeset(%Location{}, @invalid_attrs)
    refute changeset.valid?
  end
end
