# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "19e0c8bd6f87dd4282f3d81cb70b47bad215b21a"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "ae310beee3ff9891b7a8ff0e82e8efec3866060d"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "44e32cba0ec9437f5aa5d888bb87df771861aadd"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "3af30759211904f0fb458a571a5853e6a68a8a95"
  ]
}
