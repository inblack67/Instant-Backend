defmodule InstantWeb.Plugs.SetGraphqlAuth do
  import Plug.Conn

  alias Instant.Auth.UserRepo
  alias InstantWeb.Utils.Constants

  def init(_params) do
  end

  def call(conn, _params) do
    conn
    # user_id = Plug.Conn.get_session(conn, :current_user_id)

    # if user_id do
    #   cond do
    #     user = UserRepo.get_by_id(user_id) ->
    #       conn =
    #         conn
    #         |> assign(:current_user, user)

    #       Absinthe.Plug.put_options(conn, context: %{current_user: user})

    #     true ->
    #       conn
    #       |> assign(:current_user, nil)
    #       |> assign(:user_signed_in?, false)
    #   end
    # else
    #   send_resp(conn, 401, Constants.not_authenticated())
    #   conn |> halt()
    # end
  end
end
