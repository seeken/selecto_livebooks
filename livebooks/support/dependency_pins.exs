# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "4d649f3a12ffb751d7ce7803dad69ba77103a70b"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "5c61491d517d942dd98d849cb765821fb34acac1"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "b8f90e07609e78ef59019009ab81f29df1cf0e89"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "1a1ef9da5681b700a8916391329f83c78cdd37a9"
  ]
}
