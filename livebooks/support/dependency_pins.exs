# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "a882e72f94b14c3485cb57de0a48ba4c605e4c0d"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "382a911090926c6bc382a3096a4870fb899aec1e"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "7a20e5bdd0f2404ce4921caff0f67bcad8052397"
  ]
}
