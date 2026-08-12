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
- `selecto_updato_nested_writes_workbook.livemd`
- `selecto_strict_mode_workbook.livemd`
- `selecto_verification_workbook.livemd`
- `selecto_components_analytics_workbook.livemd`

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
  related packages when the full Selecto workspace is present.
- Outside the mono-workspace, the project uses pinned Git commits for the
  coordinated Selecto, PostgreSQL adapter, Updato, and Components revisions.
  This is intentional while the versions used here are newer than their Hex
  releases; standalone installs do not claim that unpublished packages exist.
- Set `SELECTO_ECOSYSTEM_USE_LOCAL=0` to exercise the pinned standalone path.
  `SELECTO_LIVE_SELECTO_PATH`, `SELECTO_LIVE_SELECTO_DB_POSTGRESQL_PATH`,
  `SELECTO_LIVE_SELECTO_UPDATO_PATH`, and
  `SELECTO_LIVE_SELECTO_COMPONENTS_PATH` can target explicit checkouts.
- Shared runtime setup for repo config, domain loading, and SQL health checks now
  lives in `SelectoLivebooks.NotebookSupport`.

## Current Notebook Parity Notes

- Core workbooks use shared setup helpers and current `Selecto.ExprMacros` /
  `~SELECTO` examples.
- The strict-mode workbook covers validated sealed domains, governed joins and
  domain SQL, eager raw-SQL rejection, and seal checks at compilation.
- The verification workbook runs bounded-exhaustive read, contract, write,
  portable-command, nested-graph, action-authorization, and Components
  visibility models. Current Updato contributes four models and 640 checks.
  The Updato tours own the PostgreSQL write-adapter conformance, generated-key,
  owned-set synchronization, and transactional rollback probes.
- The Components analytics workbook demonstrates column-local defaults and the
  shared Aggregate-to-Graph analytical query shape introduced in Components
  0.4.12, Graph URL-state preservation, and finite filter vocabularies.
- Added `selecto_domain_extensions_workbook.livemd` for view-backed domains,
  published views, and overlay DSL examples that were previously missing from
  the livebook set.
- Output-format workbook includes explicit `execute_stream/2` contract guidance
  (`supports?(:stream)` + `stream/4` + compatible connection input) for
  adapter-backed streaming paths.
- The flat Updato feature tour covers `required_on: [:insert]`, tenant and
  foreign-key context, domain-owned upsert policy, and transactional
  cardinality rollback.
- The nested-write workbook covers complete child domains, atomic portable
  graphs, generated ownership keys, per-level tenant scope, strict relationship
  validation, and delete-missing owned-set synchronization. The PostgreSQL
  adapter selects native `MERGE` on supported servers or an ordered fallback.
- Group-by workbook includes PostgreSQL ROLLUP ordering compatibility notes,
  including PG18+ behavior where rollup compatibility wrapping can be disabled.
- Guide examples include read-side tenant scope helpers and UDF-backed scalar /
  table-function query patterns.
- Set-operation coverage includes filtered operands, globally renumbered bound
  parameters, and outer ordering/limit composition.
- Tests parse every Elixir Livebook cell and execute focused regressions for
  the current strict, verification, set-operation, analytical-default, and
  portable-write boundaries.

The Updato workbooks are validated against the portable 0.4 command and graph
contracts. The standalone bootstrap pins coordinated Selecto 0.4.11,
PostgreSQL adapter 0.4.9, Updato 0.4.0, and Components 0.4.12 repository
revisions; sibling checkouts remain the default for ecosystem development.
The default-branch Updato cells now use write policy colocated with source
columns and associations. Selecto normalizes that form into canonical
`writes.fields` and `writes.relationships`; the standalone refs must advance
before those new cells can run against pinned dependencies.

## Database Model

Seeds create an e-commerce style model with:

- categories, suppliers, products, tags
- customers, orders, order_items
- employees (hierarchy)
- reviews
