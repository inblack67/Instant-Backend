defmodule InstantWeb.Schema do
  use Absinthe.Schema

  import_types(InstantWeb.Schema.Types)

  alias InstantWeb.Resolvers.UserResolver

  query do
    @desc "hello"
    field :hello, :string do
      resolve(fn _, _ -> {:ok, "hello worlds"} end)
    end
  end

  mutation do
    @desc "Register a new user"
    field :register_user, type: :boolean do
      arg(:input, non_null(:register_user_input_type))
      resolve(&UserResolver.register_user/3)
    end
  end
end
