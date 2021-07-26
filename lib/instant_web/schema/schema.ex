defmodule InstantWeb.Schema do
  use Absinthe.Schema

  import_types(InstantWeb.Schema.Types)

  alias InstantWeb.Resolvers.UserResolver

  query do
    @desc "hello"
    field :hello, :string do
      resolve(fn _, _ -> {:ok, "hello worlds"} end)
    end

    @desc "Get all Users"
    field :users, list_of(:user_type) do
      resolve(&UserResolver.get_users/3)
    end
  end

  mutation do
    @desc "Register a new user"
    field :register_user, type: :boolean do
      arg(:input, non_null(:register_user_input_type))
      resolve(&UserResolver.register_user/3)
    end

    @desc "Login User"
    field :login_user, type: :boolean do
      arg(:input, non_null(:login_user_input_type))
      resolve(&UserResolver.login_user/3)

      middleware(fn resolution, _ ->
        IO.puts("resolution => ")
        IO.inspect(resolution.value)
        IO.inspect(resolution)

        case resolution.value do
          {:ok, loggedIn?} ->
            IO.puts("ok ran")
            IO.inspect(loggedIn?)
            Map.update!(resolution, :context, &Map.put(&1, :loggedIn?, loggedIn?))

          _ ->
            resolution
        end
      end)
    end
  end
end
