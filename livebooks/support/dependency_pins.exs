# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "74b4fa03370d0b98c8fbcaa750695f2637efd2c5"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "082bc83dc1283bdc687133fada202506eacd0b73"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "92268b0a433e1de2ebb86257445883457e67b81d"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "fa7f821f6095fbc6b57d48ce483aaa5c418eb39a"
  ]
}
