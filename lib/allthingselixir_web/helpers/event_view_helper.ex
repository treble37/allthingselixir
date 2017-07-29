defmodule Allthingselixir.Web.EventViewHelper do
  def conf_date_format(datetime) do
    {status, datetime} = Timex.format(datetime, "%m/%d/%Y", :strftime)
    formatted_date(status, datetime)
  end

  defp formatted_date(:ok, date_str), do: date_str
  defp formatted_date(:error, _date_str), do: "N/A"
end

