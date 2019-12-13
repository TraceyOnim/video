# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :upload,
  ecto_repos: [Upload.Repo]

# Configures the endpoint
config :upload, UploadWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yDUNAYNacvDHKw+S53jZoTn74x0emln9BJ2y+9n1iqrdmsHT93x4l51FVxGS8xY+",
  render_errors: [view: UploadWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Upload.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :arc,
  storage: Arc.Storage.Local

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
