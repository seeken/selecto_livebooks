defmodule SelectoLivebooks.NotebookIntegrityTest do
  use ExUnit.Case, async: true

  @repo_root Path.expand("..", __DIR__)
  @livebook_dir Path.join(@repo_root, "livebooks")

  test "all Livebook Elixir cells parse" do
    @livebook_dir
    |> Path.join("*.livemd")
    |> Path.wildcard()
    |> Enum.flat_map(&elixir_cells/1)
    |> Enum.each(fn {path, index, source} ->
      assert {:ok, _ast} = Code.string_to_quoted(source),
             "Elixir cell #{index} in #{Path.relative_to(path, @repo_root)} does not parse"
    end)
  end

  test "bootstrap resolves sibling SelectoUpdato checkout when present" do
    bootstrap_path = Path.join(@livebook_dir, "support/bootstrap.exs")
    Code.require_file(bootstrap_path)

    updato_root = Path.expand("../selecto_updato", @repo_root)

    if File.dir?(updato_root) do
      assert {:selecto_updato, [path: ^updato_root, override: true]} =
               apply(SelectoLivebooksNotebookBootstrap, :updato_dep, [])
    end
  end

  test "bootstrap prefers sibling Selecto ecosystem checkouts when present" do
    bootstrap_path = Path.join(@livebook_dir, "support/bootstrap.exs")
    Code.require_file(bootstrap_path)

    selecto_root = Path.expand("../selecto", @repo_root)
    selecto_db_postgresql_root = Path.expand("../selecto_db_postgresql", @repo_root)

    if File.dir?(selecto_root) do
      assert {:selecto, [path: ^selecto_root, override: true]} =
               apply(SelectoLivebooksNotebookBootstrap, :selecto_dep, [])
    end

    if File.dir?(selecto_db_postgresql_root) do
      assert {:selecto_db_postgresql, [path: ^selecto_db_postgresql_root, override: true]} =
               apply(SelectoLivebooksNotebookBootstrap, :selecto_db_postgresql_dep, [])
    end
  end

  test "bootstrap exposes repo config for Livebook Mix.install startup" do
    bootstrap_path = Path.join(@livebook_dir, "support/bootstrap.exs")
    Code.require_file(bootstrap_path)

    repo_config = apply(SelectoLivebooksNotebookBootstrap, :repo_config, [])

    assert repo_config[:database] ==
             System.get_env("SELECTO_LIVEBOOKS_DB", "selecto_livebooks_dev")

    assert repo_config[:username] == System.get_env("SELECTO_LIVEBOOKS_DB_USER", "postgres")
    assert repo_config[:hostname] == System.get_env("SELECTO_LIVEBOOKS_DB_HOST", "localhost")

    assert repo_config[:port] ==
             String.to_integer(System.get_env("SELECTO_LIVEBOOKS_DB_PORT", "5432"))

    assert repo_config[:pool_size] ==
             String.to_integer(System.get_env("SELECTO_LIVEBOOKS_DB_POOL_SIZE", "5"))
  end

  test "tenant-scope guide example generates scoped SQL" do
    domain =
      SelectoLivebooks.Domains.OrderDomain.domain()
      |> Map.put(:tenant_required, true)

    query =
      domain
      |> Selecto.configure(:mock_connection)
      |> Selecto.with_tenant(%{
        tenant_id: 1,
        tenant_field: "customer_id",
        required: true,
        prefix: "tenant_customer_1"
      })
      |> Selecto.apply_tenant_scope()
      |> Selecto.select(["order_number", "customer.name", "total"])
      |> Selecto.filter({"status", "delivered"})
      |> Selecto.limit(5)

    assert :ok = Selecto.validate_tenant_scope(query)
    assert Selecto.required_filters(query) == [{"customer_id", 1}]
    assert Selecto.tenant_required?(query)
    assert Selecto.Tenant.merge_execution_opts(query)[:prefix] == "tenant_customer_1"

    {sql, params} = Selecto.to_sql(query)

    assert sql =~ ~r/customer_id/i
    assert params == [1, "delivered"]
  end

  test "UDF guide example generates scalar and table-function SQL" do
    domain =
      SelectoLivebooks.Domains.ProductDomain.domain()
      |> Map.put(:functions, %{
        "lower_text" => %{
          kind: :scalar,
          sql_name: "lower",
          args: [%{name: :value, type: :string, source: :selector}],
          returns: :string,
          allowed_in: [:select, :order_by]
        },
        "series" => %{
          kind: :table,
          sql_name: "generate_series",
          args: [
            %{name: :start, type: :integer, source: :value},
            %{name: :stop, type: :integer, source: :value}
          ],
          returns: %{columns: %{value: %{type: :integer}}},
          allowed_in: [:lateral, :query_member]
        }
      })

    query =
      domain
      |> Selecto.configure(:mock_connection)
      |> Selecto.with_lateral(Selecto.udf_table("series", [1, 3]),
        as: "stock_bucket",
        join_type: :left
      )
      |> Selecto.select([
        Selecto.Expr.as(Selecto.udf("lower_text", ["name"]), "normalized_name"),
        "sku",
        "stock_bucket.value"
      ])
      |> Selecto.order_by([
        Selecto.Expr.as(Selecto.udf("lower_text", ["name"]), "normalized_name")
      ])
      |> Selecto.limit(5)

    {sql, params} = Selecto.to_sql(query)

    assert sql =~ ~r/lower\s*\(selecto_root\.name\)/i
    assert sql =~ ~r/generate_series\s*\(/i
    assert sql =~ ~r/join\s+lateral/i
    assert sql =~ ~r/stock_bucket\.value/i
    assert params == [1, 3]
  end

  test "retarget workbook accepts target-root post filters" do
    query =
      SelectoLivebooks.Domains.OrderDomain.domain()
      |> Selecto.configure(:mock_connection)
      |> Selecto.filter({"status", "delivered"})
      |> Selecto.retarget(:order_items, subquery_strategy: :exists)
      |> Selecto.post_retarget_filter({"quantity", 2})
      |> Selecto.select(["order_items.product_id", "order_items.quantity"])
      |> Selecto.limit(5)

    {sql, params} = Selecto.to_sql(query)

    assert sql =~ ~r/from\s+order_items\s+t/i
    assert sql =~ ~r/t\.quantity\s*=\s*\$2/i
    assert params == ["delivered", 2]
  end

  test "selection workbook nested subselect generates child JSON aggregate" do
    query =
      SelectoLivebooks.Domains.OrderDomain.domain()
      |> Selecto.configure(:mock_connection)
      |> Selecto.select(["order_number", "status", "total"])
      |> Selecto.subselect([
        %{
          target_schema: :order_items,
          fields: ["quantity", "line_total"],
          format: :json_agg,
          alias: "line_items",
          join_path: [:order_items],
          nested: [
            %{
              key: "product",
              target_schema: :products,
              fields: ["name", "sku"],
              format: :json_agg,
              join_path: [:order_items, :product]
            }
          ]
        }
      ])
      |> Selecto.limit(5)

    {sql, params} = Selecto.to_sql(query)

    assert sql =~ ~r/json_agg\(json_build_object/i
    assert sql =~ "'product'"
    assert sql =~ ~r/from\s+products\s+sub_order_items_product/i
    assert sql =~ ~r/sub_order_items_product\."id"\s*=\s*sub_order_items\."product_id"/i
    assert sql =~ ~r/as\s+"line_items"/i
    assert params == []
  end

  test "subquery join workbook exposes macro-selected subquery fields" do
    import Selecto.ExprMacros

    high_value_delivered_orders =
      SelectoLivebooks.Domains.OrderDomain.domain()
      |> Selecto.configure(:mock_connection)
      |> Selecto.select(select([customer_id, order_number, total]))
      |> Selecto.filter(where(status == "delivered" and total > 500))

    query =
      SelectoLivebooks.Domains.CustomerDomain.domain()
      |> Selecto.configure(:mock_connection)
      |> Selecto.join_subquery(:high_value_delivered, high_value_delivered_orders,
        type: :inner,
        on: [%{left: "id", right: "customer_id"}]
      )
      |> Selecto.select(
        select([
          name,
          tier,
          country,
          high_value_delivered.order_number,
          high_value_delivered.total
        ])
      )
      |> Selecto.order_by(order_by([desc(high_value_delivered.total)]))
      |> Selecto.limit(10)

    {sql, params} = Selecto.to_sql(query)

    assert sql =~ ~r/inner\s+join\s+\(/i
    assert sql =~ ~r/high_value_delivered\.order_number/i
    assert sql =~ ~r/high_value_delivered\.total/i
    assert params == ["delivered", 500]
  end

  defp elixir_cells(path) do
    path
    |> File.read!()
    |> String.split(~r/^```elixir\s*$/m)
    |> tl()
    |> Enum.with_index(1)
    |> Enum.map(fn {rest, index} ->
      source =
        rest
        |> String.split("```", parts: 2)
        |> hd()

      {path, index, source}
    end)
  end
end
