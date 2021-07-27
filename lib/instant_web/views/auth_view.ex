defmodule InstantWeb.AuthView do
  use InstantWeb, :view

  def render("acknowledge.json", %{message: message}) do
    %{success: true, message: message}
  end

  def render("getme.json", %{current_user: current_user}) do
    %{
      success: true,
      data: %{
        current_user: %{
          username: current_user.username,
          email: current_user.email,
          name: current_user.name,
          inserted_at: current_user.inserted_at
        }
      }
    }
  end

  def render("error.json", %{error: error}) do
    %{success: false, error: error}
  end

  def render("error.json", %{errors: errors}) do
    %{success: false, errors: errors}
  end
end
