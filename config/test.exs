import Config

config :selecto_livebooks, SelectoLivebooks.Repo,
  database: "selecto_livebooks_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox

config :logger, level: :warning
