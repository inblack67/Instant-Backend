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
    @desc "Login User"
    field :login_user, type: :boolean do
      arg(:input, non_null(:login_user_input_type))
      resolve(&UserResolver.login_user/3)
    end
  end

  subscription do
    field :login_subscription, :string do
      config(fn args, _ ->
        IO.puts("args => ")
        IO.inspect(args)
        {:ok, topic: "login"}
      end)

      trigger(:login_user,
        topic: fn res ->
          IO.puts("res *")
          IO.inspect(res)
          "login"
        end
      )

      resolve(fn res, _, _ ->
        IO.puts("subs resolving with **")
        IO.inspect(res)
        {:ok, "loggedin"}
      end)
    end
  end
end
