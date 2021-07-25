defmodule InstantWeb.Resolvers.UserResolver do
  alias Instant.Auth.UserRepo
  alias InstantWeb.Utils

  def get_users(_, _, _) do
    users = UserRepo.get_all()
    {:ok, users}
  end

  def register_user(_, %{input: input}, _) do
    res = UserRepo.add(input)

    case res do
      {:ok, _} ->
        {:ok, true}

      {:error, %Ecto.Changeset{} = changeset} ->
        formatted_errors = Utils.format_changeset_errors(changeset)
        {:error, formatted_errors}

      {_, _} ->
        {:error, "Internal Server Error"}
    end
  end
end
