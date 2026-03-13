defmodule SelectoExamples.MixProject do
  use Mix.Project

  def project do
    [
      app: :selecto_examples,
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
      mod: {SelectoExamples.Application, []}
    ]
  end

  defp deps do
    [
      {:ecto_sql, "~> 3.11"},
      {:postgrex, "~> 0.17"},
      {:selecto_db_adapter,
       github: "seeken/selecto_db_adapter",
       ref: "958f660806de3d778816f21883b51f889178f35a",
       override: true},
      {:selecto,
       github: "seeken/selecto", ref: "0603beaea1555217db49be0ab79c240c0b629416", override: true},
      {:selecto_db_postgresql,
       github: "seeken/selecto_db_postgresql",
       ref: "e14bb7ab0c5835b7bdaa1865f14eed5099687e2a",
       override: true},
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
