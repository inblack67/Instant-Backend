defmodule InstantWeb.AuthView do
  use InstantWeb, :view

  def render("new.json", _payload) do
    %{success: true, message: "hello worlds"}
  end

  def render("loggedin.json", _payload) do
    %{success: true, message: "Logged In"}
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

  def render("delete.json", _payload) do
    %{success: true, message: "Logged Out"}
  end

  def render("error.json", %{error: error}) do
    %{success: false, error: error}
  end
end
