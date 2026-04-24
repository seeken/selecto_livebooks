defmodule SelectoLivebooksNotebookBootstrap do
  @moduledoc false

  @project_root Path.expand("../..", __DIR__)
  @workspace_root Path.expand("../../..", __DIR__)
  @selecto_root Path.join(@workspace_root, "selecto")
  @selecto_db_postgresql_root Path.join(@workspace_root, "selecto_db_postgresql")
  @updato_root Path.join(@workspace_root, "selecto_updato")

  def install!(extra_deps \\ []) do
    selecto_livebooks_dep = {:selecto_livebooks, path: @project_root, override: true}
    repo_config = repo_config()

    Mix.install(
      [
        selecto_dep(),
        selecto_db_postgresql_dep(),
        selecto_livebooks_dep,
        {:kino, "~> 0.12"}
      ] ++ List.wrap(extra_deps),
      config: [
        selecto_livebooks: [
          {SelectoLivebooks.Repo, repo_config},
          ecto_repos: [SelectoLivebooks.Repo]
        ]
      ]
    )

    assert_retarget_filter_runtime!()

    IO.puts("Using Selecto dependency: #{inspect(selecto_dep())}")
    IO.puts("Using Selecto DB PostgreSQL dependency: #{inspect(selecto_db_postgresql_dep())}")
    IO.puts("Using SelectoLivebooks dependency: #{inspect(selecto_livebooks_dep)}")
    IO.puts("Using SelectoLivebooks repo config: #{inspect(redact_password(repo_config))}")
    IO.puts("Loaded Selecto.Query from: #{loaded_module_path(Selecto.Query)}")
    :ok
  end

  def repo_config do
    [
      database: env("SELECTO_LIVEBOOKS_DB", "selecto_livebooks_dev"),
      username: env("SELECTO_LIVEBOOKS_DB_USER", "postgres"),
      password: env("SELECTO_LIVEBOOKS_DB_PASS", "postgres"),
      hostname: env("SELECTO_LIVEBOOKS_DB_HOST", "localhost"),
      port: env_int("SELECTO_LIVEBOOKS_DB_PORT", 5432),
      pool_size: env_int("SELECTO_LIVEBOOKS_DB_POOL_SIZE", 5)
    ]
  end

  def selecto_dep do
    if File.dir?(@selecto_root) do
      {:selecto, path: @selecto_root, override: true}
    else
      {:selecto, ">= 0.4.0 and < 0.6.0", override: true}
    end
  end

  def selecto_db_postgresql_dep do
    if File.dir?(@selecto_db_postgresql_root) do
      {:selecto_db_postgresql, path: @selecto_db_postgresql_root, override: true}
    else
      {:selecto_db_postgresql, ">= 0.4.0 and < 0.6.0", override: true}
    end
  end

  def updato_dep do
    if File.dir?(@updato_root) do
      {:selecto_updato, path: @updato_root, override: true}
    else
      {:selecto_updato, ">= 0.1.0 and < 0.3.0", override: true}
    end
  end

  defp env(name, default), do: System.get_env(name, default)

  defp env_int(name, default) do
    case System.get_env(name) do
      nil -> default
      value -> String.to_integer(value)
    end
  end

  defp redact_password(config) do
    Keyword.update(config, :password, nil, fn
      nil -> nil
      "" -> ""
      _password -> "[REDACTED]"
    end)
  end

  defp assert_retarget_filter_runtime! do
    selecto =
      apply(Selecto, :configure, [retarget_smoke_domain(), :mock_connection, [validate: false]])

    selecto = apply(Selecto, :retarget, [selecto, :order_items])
    apply(Selecto, :post_retarget_filter, [selecto, {"quantity", 2}])

    :ok
  rescue
    error in ArgumentError ->
      reraise """
              Selecto retarget filter smoke check failed during Livebook setup.

              The loaded Selecto runtime does not accept target-root post-retarget filters like {"quantity", 2}.
              Disconnect/reconnect the Livebook runtime, then rerun the setup cell so Mix.install reloads the local Selecto checkout.

              Loaded Selecto.Query from: #{loaded_module_path(Selecto.Query)}
              Original error: #{Exception.message(error)}
              """,
              __STACKTRACE__
  end

  defp retarget_smoke_domain do
    %{
      name: "Retarget Smoke",
      source: %{
        source_table: "orders",
        primary_key: :id,
        fields: [:id, :status],
        redact_fields: [],
        columns: %{
          id: %{type: :integer},
          status: %{type: :string}
        },
        associations: %{
          order_items: %{
            queryable: :order_items,
            field: :order_items,
            owner_key: :id,
            related_key: :order_id
          }
        }
      },
      schemas: %{
        order_items: %{
          source_table: "order_items",
          primary_key: :id,
          fields: [:id, :order_id, :quantity],
          redact_fields: [],
          columns: %{
            id: %{type: :integer},
            order_id: %{type: :integer},
            quantity: %{type: :integer}
          },
          associations: %{}
        }
      },
      joins: %{
        order_items: %{type: :left, name: "order_items"}
      }
    }
  end

  defp loaded_module_path(module) do
    case :code.which(module) do
      path when is_list(path) -> List.to_string(path)
      path -> inspect(path)
    end
  end
end
