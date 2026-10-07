# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "5f88d04868df1ba85165155e1f5a844886856c0e"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "79cc6e0ac9855beac978d035110f2a5007560b05"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "8c379c5c0c5731e64ac5590fcdf67d05e9464572"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "67afb8ef967ed79eef49dd78c3f5ac19f360bacf"
  ]
}
