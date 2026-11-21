# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "b38a07fde6ee0d0e3574b5a0d33da33c91c8f8a8"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "49fcdc003f1248d7a286ad592a32a8ed2f947e02"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "a929335c1194fd4ef17fc2ae584b598f8d872f57"
  ]
}
