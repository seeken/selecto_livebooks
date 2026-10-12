# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "2ccc878a29058b26f0d61fb084908bba7be0c14d"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "a7ba81111f1a10100e0a00732db763d10b7a6bf4"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "208a55094cb231b06612ce03e528d8a1fd5d4123"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "2e6548fd38d670f0369106504119fc53961ef132"
  ]
}
