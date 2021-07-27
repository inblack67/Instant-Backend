defmodule InstantWeb.AuthController do
  use InstantWeb, :controller

  alias InstantWeb.Utils
  alias Instant.Auth.User
  alias Instant.Auth.UserRepo

  plug :dont_exploit_me when action in [:create]
  plug :protect_me when action in [:index, :delete]

  def index(conn, _params) do
    render(conn, "getme.json")
  end

  def new(conn, _params) do
    render(conn, "new.json")
  end

  def create(conn, payload) do
    changeset = User.login_changeset(payload)

    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password, username: username}} ->
        user = UserRepo.get_by_username(username)

        case user do
          %User{} ->
            case Argon2.verify_pass(password, user.password) do
              true ->
                conn
                |> put_status(:created)
                |> put_session(:current_user_id, user.id)
                |> render("loggedin.json")

              _ ->
                conn
                |> render("error.json", error: "Invalid Credentials")
            end

          _ ->
            conn
            |> render("error.json", error: "Invalid Credentials")
        end

      _ ->
        conn |> render("error.json", errors: Utils.format_changeset_errors(changeset))
    end
  end

  def delete(conn, _params) do
    conn =
      conn
      |> Plug.Conn.clear_session()

    render(conn, "delete.json")
  end

  defp dont_exploit_me(conn, _params) do
    if !conn.assigns.user_signed_in? do
      conn
    else
      send_resp(conn, 401, "Already Authenticated")

      conn
      |> halt()
    end
  end

  defp protect_me(conn, _params) do
    if conn.assigns.user_signed_in? do
      conn
    else
      send_resp(conn, 401, "Not Authenticated")

      conn
      |> halt()
    end
  end
end
