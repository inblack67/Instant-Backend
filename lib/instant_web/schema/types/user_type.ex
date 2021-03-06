defmodule InstantWeb.Schema.Types.UserType do
  use Absinthe.Schema.Notation

  object :user_type do
    field :id, :id
    field :name, :string
    field :email, :string
    field :username, :string
    field :password, :string
    field :inserted_at, :string
  end

  input_object :login_user_input_type do
    field :username, non_null(:string)
    field :password, non_null(:string)
  end
end
