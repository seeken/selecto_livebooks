# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "40091a90618c5ea954f3e4c147a5be2202d78ecd"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "39c826831a6512f8f41172cc2722f50d5389e322"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "592a2954579cf303ed10b4f31741179b39618ced"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "4fc2b060f92d099e444230ac2b41091ce77c8b25"
  ]
}
