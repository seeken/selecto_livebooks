# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "0c7589592a5db10fdb130e12dd2abac2fc89b615"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "c8fca38ebff104728a7ecac14f358f2b5dc11db9"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "18a7c579be4300262041a1a58bbd6c2d488474b2"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "8a8d1d29e103ff02d3fe12f7d7513b119bacf8a4"
  ]
}
