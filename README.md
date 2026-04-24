# Selecto Livebooks

`selecto_livebooks` is the Livebook companion repo for Selecto and SelectoUpdato.
It ships a runnable example app plus focused workbooks for major feature areas.

## Structure

- `config/`, `lib/`, `priv/`, `test/` - runnable example app and dataset
- `livebooks/` - interactive notebooks grouped by topic

## Workbook Index

Core tours:
- `selecto_guide_examples.livemd`
- `selecto_selection_shapes_subselects_retargets.livemd`
- `selecto_updato_feature_tour.livemd`

Focused Selecto workbooks:
- `selecto_domain_extensions_workbook.livemd`
- `selecto_filtering_system_workbook.livemd`
- `selecto_group_by_aggregates_workbook.livemd`
- `selecto_ctes_workbook.livemd`
- `selecto_other_joins_workbook.livemd`
- `selecto_domain_join_types_workbook.livemd`
- `selecto_set_operations_workbook.livemd`
- `selecto_window_functions_workbook.livemd`
- `selecto_json_operations_workbook.livemd`
- `selecto_array_unnest_lateral_workbook.livemd`
- `selecto_case_expressions_workbook.livemd`
- `selecto_values_lookup_workbook.livemd`
- `selecto_output_formats_execution_workbook.livemd`

## Requirements

- Elixir `~> 1.18`
- PostgreSQL `13+`
- Livebook `0.12+`

## Quick Start

1. Prepare the example app:
   ```bash
   mix setup
   ```
2. Start Livebook from the project root:
   ```bash
   livebook server
   ```
3. Open any notebook under `livebooks/`.

## Dependency Policy

- Workbooks bootstrap through the local `selecto_livebooks` project using
  `livebooks/support/bootstrap.exs`.
- The project prefers sibling path deps for `selecto` and
  `selecto_db_postgresql` when the full Selecto workspace is present.
- Outside the mono-workspace, the project falls back to released package
  versions, so notebooks still run when `selecto_livebooks` is cloned alone.
- Shared runtime setup for repo config, domain loading, and SQL health checks now
  lives in `SelectoLivebooks.NotebookSupport`.

## Current Notebook Parity Notes

- Core notebook modernization is in progress. The first refresh pass moves the
  guide, filtering, and aggregates workbooks onto shared setup helpers and adds
  current `Selecto.ExprMacros` / `~SELECTO` examples.
- Added `selecto_domain_extensions_workbook.livemd` for view-backed domains,
  published views, and overlay DSL examples that were previously missing from
  the livebook set.
- Output-format workbook includes explicit `execute_stream/2` contract guidance
  (`supports?(:stream)` + `stream/4` + compatible connection input) for
  adapter-backed streaming paths.
- Updato feature tour includes tenant scope helper coverage
  (`with_tenant/2`, `apply_tenant_scope/2`, `require_tenant_filter/2|3`, and
  fail-fast scope validation).
- Group-by workbook includes PostgreSQL ROLLUP ordering compatibility notes,
  including PG18+ behavior where rollup compatibility wrapping can be disabled.
- Guide examples include read-side tenant scope helpers and UDF-backed scalar /
  table-function query patterns.
- Tests now parse every Elixir Livebook cell and assert the local
  `selecto_updato` sibling path is used when the full workspace is present.

Dependency requirement bumps are intentionally deferred until notebook behavior
is re-validated end-to-end in your environment.

## Database Model

Seeds create an e-commerce style model with:

- categories, suppliers, products, tags
- customers, orders, order_items
- employees (hierarchy)
- reviews
