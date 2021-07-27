defmodule InstantWeb.Plugs.ProtectGraphql do
  import Plug.Conn

  def init(_params) do
  end

  def call(conn, _params) do
    IO.inspect(conn)
    user_id = Plug.Conn.get_session(conn, :current_user_id)
    IO.puts("user_id => #{user_id}")

    if user_id do
      conn
    else
      send_resp(conn, 401, "Not Authenticated")
      conn |> halt()
    end
  end
end
