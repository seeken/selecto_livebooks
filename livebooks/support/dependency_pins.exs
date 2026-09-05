# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "3e667b1f98db473bd7a478f80507a01ab09e8e8a"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "216b7629b745866ef67dbb9abb4bd09126220cb1"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "66b6b3ec1f320a3d16a05548ea46334d42c66e24"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "8a8d1d29e103ff02d3fe12f7d7513b119bacf8a4"
  ]
}
