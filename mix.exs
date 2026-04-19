defmodule SelectoLivebooks.MixProject do
  use Mix.Project

  def project do
    [
      app: :selecto_livebooks,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {SelectoLivebooks.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.12"},
      {:postgrex, ">= 0.17.0"},
      selecto_dep(),
      selecto_db_postgresql_dep(),
      {:jason, "~> 1.4"},
      {:decimal, "~> 2.0"}
    ]
  end

  defp selecto_dep do
    if use_local_ecosystem?() do
      {:selecto, path: "../selecto", override: true}
    else
      {:selecto, ">= 0.4.0 and < 0.6.0", override: true}
    end
  end

  defp selecto_db_postgresql_dep do
    if use_local_ecosystem?() do
      {:selecto_db_postgresql, path: "../selecto_db_postgresql", override: true}
    else
      {:selecto_db_postgresql, ">= 0.4.0 and < 0.6.0", override: true}
    end
  end

  defp use_local_ecosystem? do
    case System.get_env("SELECTO_ECOSYSTEM_USE_LOCAL") do
      value when value in ["1", "true", "TRUE", "yes", "YES", "on", "ON"] -> true
      value when value in ["0", "false", "FALSE", "no", "NO", "off", "OFF"] -> false
      _ -> File.dir?(Path.expand("../selecto", __DIR__))
    end
  end

  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      "ecto.setup": ["ecto.create", "ecto.migrate", "run priv/repo/seeds.exs"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"]
    ]
  end
end
