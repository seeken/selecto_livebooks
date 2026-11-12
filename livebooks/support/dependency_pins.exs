# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "27a06949046a047bc497ad5a0bd6a81d6f587004"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "d7dd3982fcc5e505b6808475560e86c25a7ae2eb"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "da37ed65e086024a2aa74b629468d38fcb1d1779"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "f865626cc4f0822904d794ff31b4ad1de6f2a369"
  ]
}
