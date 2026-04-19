defmodule SelectoLivebooks.NotebookSupport do
  @moduledoc """
  Shared setup and execution helpers for the `selecto_livebooks` notebooks.
  """

  alias Ecto.Adapters.SQL

  alias SelectoLivebooks.Domains.{
    CustomerDomain,
    EmployeeDomain,
    OrderDomain,
    OrderItemDomain,
    ProductDomain
  }

  alias SelectoLivebooks.Repo

  @default_domains [
    :product_domain,
    :order_domain,
    :customer_domain,
    :employee_domain,
    :order_items_domain
  ]

  @domain_modules %{
    product_domain: ProductDomain,
    order_domain: OrderDomain,
    customer_domain: CustomerDomain,
    employee_domain: EmployeeDomain,
    order_items_domain: OrderItemDomain
  }

  @doc """
  Returns repo configuration with environment overrides applied.
  """
  def repo_config do
    base = Application.get_env(:selecto_livebooks, Repo, [])

    base
    |> Keyword.put(
      :database,
      env("SELECTO_LIVEBOOKS_DB", Keyword.get(base, :database, "selecto_livebooks_dev"))
    )
    |> Keyword.put(
      :username,
      env("SELECTO_LIVEBOOKS_DB_USER", Keyword.get(base, :username, "postgres"))
    )
    |> Keyword.put(
      :password,
      env("SELECTO_LIVEBOOKS_DB_PASS", Keyword.get(base, :password, "postgres"))
    )
    |> Keyword.put(
      :hostname,
      env("SELECTO_LIVEBOOKS_DB_HOST", Keyword.get(base, :hostname, "localhost"))
    )
    |> Keyword.put(:port, env_int("SELECTO_LIVEBOOKS_DB_PORT", Keyword.get(base, :port, 5432)))
    |> Keyword.put(
      :pool_size,
      env_int("SELECTO_LIVEBOOKS_DB_POOL_SIZE", Keyword.get(base, :pool_size, 5))
    )
  end

  @doc """
  Starts the shared repo unless it is already running.
  """
  def ensure_repo_started do
    case Process.whereis(Repo) do
      nil -> Repo.start_link(repo_config())
      pid -> {:ok, pid}
    end
  end

  @doc """
  Returns a notebook config map with the requested domains and shared repo.
  """
  def config(domain_keys \\ @default_domains) do
    {:ok, _pid} = ensure_repo_started()

    domain_keys
    |> Enum.map(fn key -> {key, domain(key)} end)
    |> Map.new()
    |> Map.put(:repo, Repo)
  end

  @doc """
  Loads a configured domain by its notebook config key.
  """
  def domain(key) do
    @domain_modules
    |> Map.fetch!(key)
    |> then(& &1.domain())
  end

  @doc """
  Returns row counts for the given dataset tables.
  """
  def table_counts(tables \\ ["products", "orders", "order_items", "customers", "employees"]) do
    {:ok, _pid} = ensure_repo_started()

    Map.new(tables, fn table -> {table, table_count(table)} end)
  end

  @doc """
  Returns the PostgreSQL server major version for compatibility notes.
  """
  def postgres_major_version do
    {:ok, _pid} = ensure_repo_started()

    %{rows: [[server_version_num]]} = SQL.query!(Repo, "show server_version_num", [])

    server_version_num
    |> to_string()
    |> String.to_integer()
    |> div(10_000)
  end

  @doc """
  Executes a query after printing lightweight SQL-health checks.
  """
  def execute_with_checks(query, opts \\ []) do
    label = Keyword.get(opts, :example, "Query")
    {sql, params} = Selecto.to_sql(query)

    IO.puts("\n[Checks] #{label}")
    print_check("SQL generated", String.trim(sql) != "")
    print_check("FROM clause present", valid_from_clause?(sql))
    print_check("params available", is_list(params))
    print_check("CTE appears consumed (if present)", cte_consumed?(sql))

    Selecto.execute(query)
  end

  defp table_count(table) when is_binary(table) do
    if Regex.match?(~r/\A[a-z_][a-z0-9_]*\z/, table) do
      %{rows: [[count]]} = SQL.query!(Repo, "select count(*) from #{table}", [])
      count
    else
      raise ArgumentError, "unsafe table name for notebook helper: #{inspect(table)}"
    end
  end

  defp env(name, default), do: System.get_env(name, default)

  defp env_int(name, default) do
    case System.get_env(name) do
      nil -> default
      value -> String.to_integer(value)
    end
  end

  defp valid_from_clause?(sql) do
    has_from = Regex.match?(~r/\bfrom\s+\S/m, sql)
    bad_from = Regex.match?(~r/\bfrom\s*(\n|\r\n)\s*where\b/mi, sql)
    has_from and not bad_from
  end

  defp cte_consumed?(sql) do
    case Regex.run(~r/\bWITH(?:\s+RECURSIVE)?\s+([a-zA-Z_][a-zA-Z0-9_]*)\s+AS\b/m, sql) do
      nil ->
        true

      [_, cte_name] ->
        Regex.scan(~r/\b#{Regex.escape(cte_name)}\b/, sql)
        |> length()
        |> Kernel.>(1)
    end
  end

  defp print_check(name, true), do: IO.puts("  [PASS] #{name}")
  defp print_check(name, false), do: IO.puts("  [FAIL] #{name}")
end
