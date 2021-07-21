defmodule InstantWeb.Schema.Types do
  use Absinthe.Schema.Notation

  alias InstantWeb.Schema.Types

  import_types(Types.UserType)
end
