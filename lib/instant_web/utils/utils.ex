defmodule InstantWeb.Utils do
  def format_changeset_errors(changeset_errors) do
    errors =
      Enum.map(changeset_errors, fn error ->
        {field_name, {message, _}} = error
        formatted_error = "#{field_name} #{message}"
        formatted_error
      end)

    errors
  end
end
