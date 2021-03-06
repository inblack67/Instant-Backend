defmodule InstantWeb.Resolvers.UserResolver do
  alias Instant.Auth.User
  alias Instant.Auth.UserRepo
  alias InstantWeb.Utils.Constants

  def login_user(_, %{input: %{password: password, username: username}}, _) do
    user = UserRepo.get_by_username(username)

    case user do
      %User{} ->
        case Argon2.verify_pass(password, user.password) do
          true ->
            {:ok, true}

          _ ->
            {:error, Constants.invalid_credentials()}
        end

      _ ->
        {:error, Constants.invalid_credentials()}
    end
  end

  def get_users(_, _, %{context: _context}) do
    users = UserRepo.get_all()
    {:ok, users}
  end
end
