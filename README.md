# Selecto Livebooks

`selecto_livebooks` is the Livebook companion repo for Selecto and SelectoUpdato.
It ships a runnable example app plus focused workbooks for major feature areas.

## Structure

- `selecto_examples/` - Ecto app with schemas, domains, migrations, and seeds
- `selecto_examples/livebooks/` - interactive notebooks grouped by topic

## Workbook Index

Core tours:
- `selecto_guide_examples.livemd`
- `selecto_selection_shapes_subselects_pivots.livemd`
- `selecto_updato_feature_tour.livemd`

Focused Selecto workbooks:
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

- Elixir `~> 1.17`
- PostgreSQL `13+`
- Livebook `0.12+`

## Quick Start

1. Prepare the example app:
   ```bash
   cd selecto_examples
   mix setup
   ```
2. Start Livebook from repo root or inside `selecto_examples`:
   ```bash
   livebook server
   ```
3. Open any notebook under `selecto_examples/livebooks/`.

## Dependency Policy

- Selecto-focused notebooks install Selecto from a pinned GitHub SHA:
  - `{:selecto, github: "seeken/selecto", ref: "f1f937e5b08f4b90c9ac5bcfa33106551c23b60a"}`
- The Updato workbook installs both Selecto libraries from pinned GitHub SHAs:
  - `{:selecto, github: "seeken/selecto", ref: "f1f937e5b08f4b90c9ac5bcfa33106551c23b60a", override: true}`
  - `{:selecto_updato, github: "seeken/selecto_updato", ref: "a04bf54bc0adfb5e53e9b015417f0b26a81e24c5"}`
- The `selecto_examples` Mix project tracks the same pinned Selecto SHA.

## Current Notebook Parity Notes

- Output-format workbook includes explicit `execute_stream/2` contract guidance
  (`supports?(:stream)` + `stream/4`) for adapter-backed streaming paths.
- Updato feature tour includes tenant scope helper coverage
  (`with_tenant/2`, `apply_tenant_scope/2`, `require_tenant_filter/2|3`, and
  fail-fast scope validation).
- Group-by workbook includes PostgreSQL ROLLUP ordering compatibility notes,
  including PG18+ behavior where rollup compatibility wrapping can be disabled.

Dependency requirement bumps are intentionally deferred until notebook behavior
is re-validated end-to-end in your environment.

## Database Model

Seeds create an e-commerce style model with:

- categories, suppliers, products, tags
- customers, orders, order_items
- employees (hierarchy)
- reviews
