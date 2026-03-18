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
      {:ecto_sql, "~> 3.11"},
      {:postgrex, "~> 0.17"},
      {:selecto, "0.4.0", override: true},
      {:selecto_db_postgresql, "0.4.0", override: true},
      {:jason, "~> 1.4"},
      {:decimal, "~> 2.0"}
    ]
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
