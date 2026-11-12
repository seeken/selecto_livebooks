# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "4527a0f434f361597509d7e4cfd340d7b730514a"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "7eae0260462b3541377874ecc68917aac4b0cde7"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "ecd9376860eb3369bd7b13f27c4d6c8596741c95"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "5af2581b744f2938984fbe11356da2e21047df6d"
  ]
}
