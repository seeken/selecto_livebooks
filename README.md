# Selecto Livebooks

A runnable learning companion for Selecto, SelectoUpdato, and SelectoComponents.
Start with a short workflow, then use the SQL-operator workbooks as references.
The [September 2026 relevance review](docs/workbook-review.md) records coverage,
corrections, and what the checks do—and do not—prove.

## Start here

1. [Your first query](livebooks/selecto_first_query_workbook.livemd): a minimal
   domain, explicit runtime, bound parameters, and automatic join selection.
2. [Reusable queries](livebooks/selecto_query_library_workbook.livemd): compose
   segments, projections, orderings, and views; validate saved request intent.
3. [Stable pagination](livebooks/selecto_pagination_workbook.livemd): tie-breakers,
   keyset boundaries, look-ahead rows, and offset drift after an insertion.
4. [Tenant-scoped reads](livebooks/selecto_tenant_reads_workbook.livemd): trusted
   context, missing scope, optional OR filters, and real cross-tenant isolation checks.

The first two need no database. The next two need only an existing PostgreSQL
database; they create deterministic **temporary tables**, not permanent data.

## Workbook index

**No database** — every Elixir cell is executed by the default test suite:

| Workbook | Use it for |
| --- | --- |
| [First query](livebooks/selecto_first_query_workbook.livemd) | Compile/execute distinction, immutability, automatic joins, parameters |
| [Query library](livebooks/selecto_query_library_workbook.livemd) | Reusable business definitions and typed external parameters |
| [Strict mode](livebooks/selecto_strict_mode_workbook.livemd) | Sealed domains and caller-authored SQL rejection |
| [Domain extensions](livebooks/selecto_domain_extensions_workbook.livemd) | View DDL compilation, explicit adapters, overlays and drift checks |
| [Components analytics](livebooks/selecto_components_analytics_workbook.livemd) | Shared Aggregate/Graph state, defaults and URL preservation |
| [Bounded verification](livebooks/selecto_verification_workbook.livemd) | Named finite safety models and their proof limits |

**PostgreSQL, isolated fixtures** — fresh-session execution is opt-in:

| Workbook | Use it for |
| --- | --- |
| [Pagination](livebooks/selecto_pagination_workbook.livemd) | Deterministic pages, cursor validation, concurrent insertion example |
| [Tenant reads](livebooks/selecto_tenant_reads_workbook.livemd) | Asserted read-side scope and visibility enforcement |
| [Updato feature tour](livebooks/selecto_updato_feature_tour.livemd) | Governed insert/update/upsert/delete, conformance and rollback |
| [Nested writes](livebooks/selecto_updato_nested_writes_workbook.livemd) | Generated keys, owned-child synchronization and atomic graphs |

**Seeded PostgreSQL reference track** — run `mix setup` in a disposable database:

| Workbook | Use it for |
| --- | --- |
| [Complete guide](livebooks/selecto_guide_examples.livemd) | The broad 42-section reference tour |
| [Selections, subselects, retargets](livebooks/selecto_selection_shapes_subselects_retargets.livemd) | Flat rows vs nested collections; avoid accidental row multiplication |
| [Filtering](livebooks/selecto_filtering_system_workbook.livemd) | Typed predicates, boolean composition, subqueries and result comparisons |
| [Group-by and aggregates](livebooks/selecto_group_by_aggregates_workbook.livemd) | Reporting grain, totals, HAVING, ROLLUP/CUBE |
| [CTEs](livebooks/selecto_ctes_workbook.livemd) | Reusable subqueries, recursive trees and composition |
| [Other joins](livebooks/selecto_other_joins_workbook.livemd) | Parameterized, dynamic and subquery joins; advanced reference |
| [Domain join types](livebooks/selecto_domain_join_types_workbook.livemd) | OLAP/hierarchy markers; metadata previews vs executable queries |
| [Set operations](livebooks/selecto_set_operations_workbook.livemd) | UNION/INTERSECT/EXCEPT, duplicate semantics and bound parameters |
| [Window functions](livebooks/selecto_window_functions_workbook.livemd) | Ranking, running totals, frames and partitioned analytics |
| [JSON operations](livebooks/selecto_json_operations_workbook.livemd) | PostgreSQL JSON paths, extraction and reporting |
| [Arrays, UNNEST, LATERAL](livebooks/selecto_array_unnest_lateral_workbook.livemd) | Collection expansion and preserving unmatched parents |
| [CASE expressions](livebooks/selecto_case_expressions_workbook.livemd) | Business buckets, nullable values and conditional priority |
| [VALUES lookups](livebooks/selecto_values_lookup_workbook.livemd) | Small inline lookup relations and plan inspection |
| [Output formats and execution](livebooks/selecto_output_formats_execution_workbook.livemd) | Result shapes, exports, stream contracts and measurement caveats |

All 24 notebooks receive syntax/integrity checks. The seeded execution gate also
runs all 14 reference notebooks and rejects known unexpected-error markers.
Exploratory cells and intentionally printed negative cases are not exhaustive
correctness proofs; the new workflows additionally assert concrete outcomes.

## Run a notebook

Use the workspace's Mise toolchain (or a compatible Elixir runtime; verified
with Elixir 1.20) and Livebook. From this repository:

```bash
mise exec -- mix deps.get
livebook server
```

Open a notebook under `livebooks/` and run top to bottom. The setup cell installs
its dependencies in the Livebook runtime. Database-free notebooks do not need
`mix setup`. First-time dependency installation may require network access.

For database-backed notebooks, start Livebook with the database environment:

```bash
SELECTO_LIVEBOOKS_DB=selecto_livebooks_dev \
SELECTO_LIVEBOOKS_DB_HOST=localhost \
SELECTO_LIVEBOOKS_DB_PORT=5432 \
  livebook server
```

Also set `SELECTO_LIVEBOOKS_DB_USER` and `SELECTO_LIVEBOOKS_DB_PASS` as needed.
Configure the same environment for `mix setup` when using the seeded track.

**Use a disposable example database.** `mix setup` runs migrations and the seed
script deletes/replaces data in the sample tables. Several advanced reference
cells alter fixture data, define functions, or write exports. Do not point them
at production. The pagination/tenant notebooks only use session-local temporary
tables; closing their Postgrex connection drops those fixtures.

## Verification

Default: no database startup or database-creation side effect. Parses every
notebook, runs focused API regressions, and executes all six database-free
workbooks cell by cell in fresh Elixir VMs:

```bash
mise exec -- env SELECTO_ECOSYSTEM_USE_LOCAL=1 mix test
```

Live gate: point it at an **existing disposable** PostgreSQL database. No sample
migrations/seeds are required for these four workbooks:

```bash
mise exec -- env SELECTO_ECOSYSTEM_USE_LOCAL=1 \
  SELECTO_LIVEBOOKS_DB=selecto_livebooks_dev \
  SELECTO_LIVEBOOKS_DB_PORT=5432 \
  mix test --include postgres test/notebook_execution_test.exs
```

Seeded reference gate: first initialize a **disposable** database with `mix setup`
using the same environment. These 14 notebooks can modify fixture data and write
exports, so this gate is separate from both default tests and isolated fixtures:

```bash
mise exec -- env SELECTO_ECOSYSTEM_USE_LOCAL=1 \
  SELECTO_LIVEBOOKS_DB=selecto_livebooks_dev \
  SELECTO_LIVEBOOKS_DB_PORT=5432 \
  mix test --include seeded test/notebook_seeded_execution_test.exs
```

Run one workbook with the maintained runner:

```bash
mise exec -- elixir scripts/verify_notebook.exs livebooks/selecto_first_query_workbook.livemd
```

The runner preserves bindings, aliases, and imports between cells, identifies
the failing cell, and exits nonzero for uncaught failures. Assertions in the
new workflows check concrete results and negative cases, not just SQL text.

## Dependency policy

- [One dependency snapshot](livebooks/support/dependency_pins.exs) supplies the
  same immutable published Git revisions to the app and notebook bootstrap.
- Sibling checkouts are preferred in this workspace. Use
  `SELECTO_ECOSYSTEM_USE_LOCAL=0` to test standalone pinned dependencies;
  Git mode uses SSH and requires GitHub access.
- Existing `SELECTO_LIVE_SELECTO_PATH`,
  `SELECTO_LIVE_SELECTO_DB_POSTGRESQL_PATH`, `SELECTO_LIVE_SELECTO_UPDATO_PATH`,
  and `SELECTO_LIVE_SELECTO_COMPONENTS_PATH` overrides remain supported.
- Core/strict/workflow examples use explicit `Selecto.Runtime.Context` values.
  The database fixtures use Postgrex directly; Ecto belongs only to the shared
  seeded sample app, not to the Selecto query-building requirement.
- This is a checked-in runtime snapshot, not a claim that all these revisions
  are available as Hex releases.

## Structure and dataset

`livebooks/` contains notebooks and shared bootstrap/fixtures. `config/`,
`lib/`, and `priv/` contain the optional seeded app. `scripts/` and `test/`
hold the executable gates.

The seeded e-commerce model covers categories, suppliers, products, tags,
customers, orders, order items, hierarchical employees, and reviews.
