defmodule Allthingselixir.Web.EventTest do
  use Allthingselixir.ModelCase

  alias Allthingselixir.Event

  @valid_attrs %{cfp_closing_date: %{day: 17, month: 4, year: 2010}, end_date: %{day: 17, month: 4, year: 2010}, name: "some content", start_date: %{day: 17, month: 4, year: 2010}, twitter: "some content", url: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Event.changeset(%Event{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Event.changeset(%Event{}, @invalid_attrs)
    refute changeset.valid?
  end
end
