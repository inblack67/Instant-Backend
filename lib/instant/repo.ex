defmodule Instant.Repo do
  use Ecto.Repo,
    otp_app: :instant,
    adapter: Ecto.Adapters.Postgres
end
