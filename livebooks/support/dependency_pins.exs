# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "f98c920e84cb9c40f3df0e86cad5a59dd48cb256"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "aec643c6e2f85a1fddea2d9e2d2573b59e79fe56"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "171c3cdb8b4f77fe4912187f56c8b3e48174bf58"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "5af2581b744f2938984fbe11356da2e21047df6d"
  ]
}
