defmodule Allthingselixir.MetaPropertyFactory do
  defmacro __using__(_opts) do
    quote do
      def event_factory do
        %Allthingselixir.MetaProperty{
          twitter: "ElixirConf",
          url: "https://elixirconf.com/",
          start_date: ~D[2017-09-06],
          end_date: ~D[2017-09-07],
          event: build(:event)
        }
      end
    end
  end
end
