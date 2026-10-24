# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "ddb270b4827c8475cddace2c5d07c06a91071def"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "53244de0235297ad54f2f701268928128484ebea"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "29a8d6e151008f49f50e47bb5264f7b3bfd7e4bc"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "f865626cc4f0822904d794ff31b4ad1de6f2a369"
  ]
}
