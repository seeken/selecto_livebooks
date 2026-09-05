# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "b8b60cc537bd6194c5eb1568d2bee029230b5f86"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "ac9ce57d6b5c52e34af1fc30d8e026e890b10043"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "a5759de0206dc86b026fbaa835d50d4f7332e9a9"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "8a8d1d29e103ff02d3fe12f7d7513b119bacf8a4"
  ]
}
