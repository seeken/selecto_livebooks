# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "e24b60d50c1ad1741691d3f79f47a1b6dc1346ef"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "87251b8f85ca77854352ba1e85a066739c303959"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "28ac872047e6e0e47f5ba3d93663de1ed9b17bbf"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "11b37af775d8f524265c2a6ed9dbed091972c4d0"
  ]
}
