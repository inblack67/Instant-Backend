defmodule InstantWeb.AuthController do
  use InstantWeb, :controller

  alias Instant.Auth.User
  alias Instant.Auth.UserRepo
  alias InstantWeb.Utils
  alias InstantWeb.Utils.Constants

  plug :dont_exploit_me when action in [:create, :register]
  plug :protect_me when action in [:index, :delete]

  def register(conn, payload) do
    res = UserRepo.add(payload)

    case res do
      {:ok, _} ->
        conn
        |> put_status(:created)
        |> render("acknowledge.json", %{message: "Registered"})

      {:error, %Ecto.Changeset{} = changeset} ->
        conn |> render("error.json", errors: Utils.format_changeset_errors(changeset))

      true ->
        conn |> render("error.json", error: Constants.internal_server_error())
    end
  end

  def index(conn, _params) do
    render(conn, "getme.json")
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
                |> render("acknowledge.json", %{message: "Logged In"})

              _ ->
                conn
                |> render("error.json", error: Constants.invalid_credentials())
            end

          _ ->
            conn
            |> render("error.json", error: Constants.invalid_credentials())
        end

      _ ->
        conn |> render("error.json", errors: Utils.format_changeset_errors(changeset))
    end
  end

  def delete(conn, _params) do
    conn =
      conn
      |> Plug.Conn.clear_session()

    render(conn, "acknowledge.json", %{message: "Logged Out"})
  end

  defp dont_exploit_me(conn, _params) do
    if !conn.assigns.user_signed_in? do
      conn
    else
      send_resp(conn, 401, Constants.not_authorized())

      conn
      |> halt()
    end
  end

  defp protect_me(conn, _params) do
    if conn.assigns.user_signed_in? do
      conn
    else
      send_resp(conn, 401, Constants.not_authenticated())

      conn
      |> halt()
    end
  end
end
