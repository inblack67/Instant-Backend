defmodule InstantWeb.Context do
  @behaviour Plug

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _opts) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: context)
  end

  defp build_context(conn) do
    IO.puts("conn =>")
    IO.inspect(conn)
    %{}
  end

  # defp authorize(token) do
  # end
end
