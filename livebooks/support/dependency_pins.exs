# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "3a81c5ecd3c6fe430a055197ed2d35e03d45d453"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "65a7760c5a6d72ac5dd98a0f1fd65d8f26589487"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "ebad9eac7833bd638c88dc4ad74f52790aa49d74"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "589f12f7fb09341d266e24f3fed7511468017190"
  ]
}
