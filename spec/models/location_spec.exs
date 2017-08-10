defmodule Allthingselixir.LocationFactory do
  defmacro __using__(_opts) do
    quote do
      def event_factory do
        %Allthingselixir.Location{
          city: "Los Angeles",
          state: "California",
          country: "United States of America",
          postal_code: "90001",
          street_address: "1234 Main Street",
          event: build(:event)
        }
      end
    end
  end
end
