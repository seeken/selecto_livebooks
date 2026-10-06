# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "5f88d04868df1ba85165155e1f5a844886856c0e"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "3e82084dacfa8c268ba5a24b10c151b4329e0b0d"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "8c379c5c0c5731e64ac5590fcdf67d05e9464572"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "e6bc78da463b9db96ada586b261e0a44809f72f1"
  ]
}
