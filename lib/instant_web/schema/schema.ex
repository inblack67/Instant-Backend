defmodule InstantWeb.Schema do
  use Absinthe.Schema

  query do
    @desc "hello"
    field :hello, :string do
      resolve(fn _, _ -> {:ok, "hello worlds"} end)
    end
  end
end
