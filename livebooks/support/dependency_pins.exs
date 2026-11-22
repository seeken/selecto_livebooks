# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "fc07414dab4b23d3bccc2c1afb6a94a0c31c8d67"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "425a69956a8f07a85c5b46de9fcb533383ecf4e6"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "a9a135099bcbdcf50086d521c7e45f108b338591"
  ]
}
