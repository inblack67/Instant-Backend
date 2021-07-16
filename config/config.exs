# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :instant,
  ecto_repos: [Instant.Repo]

# Configures the endpoint
config :instant, InstantWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "VA5UMJ47YnG5TQWFfrz12PT2azGe2hull9tIDgfUd3XO8M4L9SxVYkkcBCSWClFX",
  render_errors: [view: InstantWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Instant.PubSub,
  live_view: [signing_salt: "O8nBfu57"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
