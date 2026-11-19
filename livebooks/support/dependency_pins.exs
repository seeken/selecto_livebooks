# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "0e98d8ec85e84c80705cd3526ea8cc46f8c9e96d"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "b22123290c51dc630e7edd37ca35a9231e145bdf"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "0833378aff9a489154ca1cecdd89e1905ec76cd4"
  ]
}
