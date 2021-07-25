defmodule InstantWeb.Utils do
  import Ecto.Changeset

  def format_changeset_errors(%Ecto.Changeset{} = changeset) do
    errors =
      traverse_errors(changeset, fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)

    formatted_errors =
      Enum.map(errors, fn el ->
        {field_name, errors} = el
        error = "#{field_name} #{to_string(errors)}"
        error
      end)

    formatted_errors
  end
end
