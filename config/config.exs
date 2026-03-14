import Config

config :selecto_livebooks,
  ecto_repos: [SelectoLivebooks.Repo]

config :selecto_livebooks, SelectoLivebooks.Repo,
  database: "selecto_livebooks_dev",
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

import_config "#{config_env()}.exs"
