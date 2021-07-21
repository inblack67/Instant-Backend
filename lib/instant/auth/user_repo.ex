defmodule Instant.Auth.UserRepo do
  import Ecto.Query

  alias Instant.Repo
  alias Instant.Auth.User

  def get_all(limit \\ 20) do
    Repo.all(
      from u in User,
        select: %{email: u.email, username: u.username, name: u.name, inserted_at: u.inserted_at},
        limit: ^limit,
        order_by: [desc: u.inserted_at]
    )
  end

  def add(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def get_by_id(id) do
    Repo.get!(User, id)
  end

  def get_by_username(username) do
    Repo.get!(User, username: username)
  end
end
