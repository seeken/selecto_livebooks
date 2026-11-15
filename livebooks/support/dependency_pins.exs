# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "0e98d8ec85e84c80705cd3526ea8cc46f8c9e96d"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "e6b59514030dae6de009eaca96106cbe6b12c3d8"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "574f7656b04de4d98a0dd20f554f9d92437988da"
  ]
}
