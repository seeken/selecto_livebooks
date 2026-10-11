# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "42af1cda37ed994bc806a6bf4fc2d71eb9a84013"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "a7ba81111f1a10100e0a00732db763d10b7a6bf4"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "a072a4d69481d9c83ffe230684986b97db544f0a"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "2e6548fd38d670f0369106504119fc53961ef132"
  ]
}
