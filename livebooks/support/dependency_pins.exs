# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "e77c1f39c13c944c56fa838aac4c7a69b2583391"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "dbec35a7715b366ffb0cd9d9d3d802122862df6a"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "e004f2f8ae3c90593e5905e7a9a56449c62ef738"
  ]
}
