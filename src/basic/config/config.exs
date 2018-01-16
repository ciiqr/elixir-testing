# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :basic,
  ecto_repos: [Basic.Repo]

# Configures the endpoint
config :basic, BasicWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nfXuEmzWXbF9WG+7kSmPLX5qXNQpR53yD81m2B2zKwyc2YRin246tVqnRNUPTVKD",
  render_errors: [view: BasicWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Basic.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
