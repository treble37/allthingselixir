defmodule Allthingselixir.LayoutView do
  use Allthingselixir.Web, :view

  def welcome_message(current_user) do
    welcome_message_with_email(current_user, current_user.email)
  end

  def welcome_message_with_email(current_user, nil), do: "Welcome, user"
  def welcome_message_with_email(current_user, email), do: "Welcome, #{email}"
end
