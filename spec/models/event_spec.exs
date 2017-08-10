defmodule Allthingselixir.EventSpec do
  use ESpec.Phoenix, model: Event, async: true
  use ExMachina.Ecto, repo: Allthingselixir.Repo
  #  import Allthingselixir.Factories

  describe "Event.find_or_create_by_name" do
    context "with a valid changeset" do
      it "should return an Event record with a valid changeset" do
#        valid_changeset = %{"name" => "ElixirConf", locations: [build(:location)], meta_properties: [build(:meta_property)]}
#                          |> Event.changeset
#        expect(valid_changeset.valid?) |> to(be_true())
      end

      it "should find an already existing event by name" do
      end

      it "should create an event by name with a valid changeset" do
      end
    end

    context "with an invalid changeset" do
      it "should return nil with a properly informatted start date" do
      end
    end
  end
end
