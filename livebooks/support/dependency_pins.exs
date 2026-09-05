# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "b673a2c59434c1409541bcec72d92ff3a29d2bef"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "af83eb64f3846c1014cf838cfcb508fe6b1c3519"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "63d4b6a15f536c0e2634482b815469389793e7fe"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "8a8d1d29e103ff02d3fe12f7d7513b119bacf8a4"
  ]
}
