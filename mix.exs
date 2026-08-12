defmodule SelectoLivebooks.MixProject do
  use Mix.Project

  @selecto_ref "8bb10c83e7fa50610c4e161b0e0b2c6f45d1b53e"
  @selecto_db_postgresql_ref "c20856b8a7816001cf9c03437e747a1447e3085c"
  @selecto_updato_ref "6842d8dba1990ce96301eacfa08e873f51c883e8"
  @selecto_components_ref "b072e50dcaa090a6aa6bd8022e3eb2f6be297d2b"

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
       "https://github.com/seeken/selecto.git",
       @selecto_ref
     ) ++ [override: true]}
  end

  defp selecto_db_postgresql_dep do
    {:selecto_db_postgresql,
     dependency_source(
       "SELECTO_LIVE_SELECTO_DB_POSTGRESQL_PATH",
       "../selecto_db_postgresql",
       "https://github.com/seeken/selecto_db_postgresql.git",
       @selecto_db_postgresql_ref
     ) ++ [override: true]}
  end

  defp selecto_updato_dep do
    {:selecto_updato,
     dependency_source(
       "SELECTO_LIVE_SELECTO_UPDATO_PATH",
       "../selecto_updato",
       "https://github.com/seeken/selecto_updato.git",
       @selecto_updato_ref
     ) ++ [override: true, only: :test]}
  end

  defp selecto_components_dep do
    {:selecto_components,
     dependency_source(
       "SELECTO_LIVE_SELECTO_COMPONENTS_PATH",
       "../selecto_components",
       "https://github.com/seeken/selecto_components.git",
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
