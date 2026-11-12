# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "356260ec40780d002f9c74ded99c83c2b03dfe64"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "37a1113008f54b26fd545aa8daed468720d29466"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "1ab271e86f9de3eb7aca421d89fa64196806bdb4"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "f865626cc4f0822904d794ff31b4ad1de6f2a369"
  ]
}
