defmodule Instant.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Instant.Auth.User

  schema "users" do
    field :email, :string
    field :name, :string
    field :password, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(user = %User{}, attrs) do
    user
    |> cast(attrs, [:username, :email, :password, :name])
    |> validate_required([:username, :email, :password, :name])
    |> unique_constraint(:username)
    |> unique_constraint(:email)
    |> validate_format(:email, ~r/@/)
    |> update_change(:email, fn el -> String.downcase(el) end)
    |> validate_length(:username, min: 5, max: 30)
    |> validate_length(:name, min: 3, max: 30)
    |> validate_length(:password, min: 8, max: 30)
    |> encryptPassword
  end

  defp encryptPassword(changeset = %Ecto.Changeset{}) do
    IO.inspect("changeset received")
    IO.inspect(changeset)

    case changeset do
      %Ecto.Changeset{valid?: true, changes: %{password: password}} ->
        put_change(changeset, :password, Argon2.hash_pwd_salt(password))

      _ ->
        changeset
    end
  end
end
