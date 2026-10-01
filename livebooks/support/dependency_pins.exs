# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "47bd5317c8249eb02e027def2dcaed891b61a955"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "eab3c43d037b4b30e7f495dc4523800114171c42"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "68d73324c3c718379fce50edd66208fc1a58d260"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "3af30759211904f0fb458a571a5853e6a68a8a95"
  ]
}
