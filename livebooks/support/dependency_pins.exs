# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "36112e99c85a98731a91c40676a0e7aa9c36db0b"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "5c61491d517d942dd98d849cb765821fb34acac1"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "6e9f6f50c18cacebd849180f98df55474fedfcd0"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "1a1ef9da5681b700a8916391329f83c78cdd37a9"
  ]
}
