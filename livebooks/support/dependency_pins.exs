# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "10c1661da67887355f2314c4294fc7baec774d9a"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "334d6e0718b7bc6dbde0ec06b672cd939942d0b1"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "1afebb2762470b624efc8fa3b7af3aea77be3f3b"
  ]
}
