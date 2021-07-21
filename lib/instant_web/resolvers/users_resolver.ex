defmodule InstantWeb.Resolvers.UserResolver do
  alias Instant.Auth.UserRepo

  def format_changeset_errors(changeset_errors) do
    errors =
      Enum.map(changeset_errors, fn error ->
        {field_name, {message, _}} = error
        IO.inspect(field_name)
        IO.inspect(message)
        formatted_error = "#{field_name} #{message}"
        formatted_error
      end)

    errors
  end

  def register_user(_, %{input: input}, _) do
    res = UserRepo.add(input)

    case res do
      {:ok, _} ->
        {:ok, true}

      {:error, %{errors: errors}} ->
        formatted_errros = format_changeset_errors(errors)
        {:error, formatted_errros}

      {_, _} ->
        {:error, "Internal Server Error"}
    end
  end
end
