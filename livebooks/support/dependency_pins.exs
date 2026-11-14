# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "7795411f738023573bf70ff744403ce386c56cf4"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "ba9a75cedda4c23e2deeefd51a13c0f792c403fe"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "330056aa5d460e5187140e118c001a137154ee8c"
  ]
}
