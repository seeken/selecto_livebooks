# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "eacb8d959ba6e002a66807a02842c7f9738966ae"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "1d127111fed391a4a41a309c199a5233fe21e06c"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "5af2581b744f2938984fbe11356da2e21047df6d"
  ]
}
