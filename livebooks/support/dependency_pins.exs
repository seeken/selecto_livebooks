# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "40091a90618c5ea954f3e4c147a5be2202d78ecd"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "b98ad5e01cb37ff82a581765c44826983f4aecb8"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "592a2954579cf303ed10b4f31741179b39618ced"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "589f12f7fb09341d266e24f3fed7511468017190"
  ]
}
