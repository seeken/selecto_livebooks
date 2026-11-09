# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "442bba4845f99190af6fe2601268aa1a55560b44"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "8b4087c16c8be913e8dfb425cd64e6fd790c2a14"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "04cbe64e4ff4a407eff9e6912b3014e11fdce622"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "f865626cc4f0822904d794ff31b4ad1de6f2a369"
  ]
}
