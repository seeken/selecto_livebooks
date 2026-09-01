defmodule SelectoLivebooks.MixProject do
  use Mix.Project

  @selecto_ref "e54cab3bbf5855e5e4e67efb336dcffd4da2b6d9"
  @selecto_db_postgresql_ref "1f8200d50a64e988a54ce662debc5b70f2d225bd"
  @selecto_updato_ref "20cb09da9110d884262df8fa14cf8de9c5429846"
  @selecto_components_ref "aabca0a3d5cbc35e6b4ea658b61a4dd03c0aef81"

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
      selecto_updato_dep(),
      selecto_components_dep(),
      {:jason, "~> 1.4"},
      {:decimal, "~> 2.0"}
    ]
  end

  defp selecto_dep do
    {:selecto,
     dependency_source(
       "SELECTO_LIVE_SELECTO_PATH",
       "../selecto",
       "git@github.com:seeken/selecto.git",
       @selecto_ref
     ) ++ [override: true]}
  end

  defp selecto_db_postgresql_dep do
    {:selecto_db_postgresql,
     dependency_source(
       "SELECTO_LIVE_SELECTO_DB_POSTGRESQL_PATH",
       "../selecto_db_postgresql",
       "git@github.com:selecto-elixir/selecto_db_postgresql.git",
       @selecto_db_postgresql_ref
     ) ++ [override: true]}
  end

  defp selecto_updato_dep do
    {:selecto_updato,
     dependency_source(
       "SELECTO_LIVE_SELECTO_UPDATO_PATH",
       "../selecto_updato",
       "git@github.com:seeken/selecto_updato.git",
       @selecto_updato_ref
     ) ++ [override: true, only: :test]}
  end

  defp selecto_components_dep do
    {:selecto_components,
     dependency_source(
       "SELECTO_LIVE_SELECTO_COMPONENTS_PATH",
       "../selecto_components",
       "git@github.com:seeken/selecto_components.git",
       @selecto_components_ref
     ) ++ [override: true, only: :test]}
  end

  defp dependency_source(path_env, sibling_path, git, ref) do
    case System.get_env(path_env) do
      path when is_binary(path) and path != "" ->
        [path: Path.expand(path)]

      _ ->
        path = Path.expand(sibling_path, __DIR__)

        if use_local_ecosystem?() and File.dir?(path) do
          [path: path]
        else
          [git: git, ref: ref]
        end
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
