# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "67d5097edb44cd7f33737548ba97770849cf2d7b"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "9312b967db5930739ca0ef9f9e1c1147bace32ee"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "066d3380adbc50235ead4aab131f953194047296"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "5b564ab24e8672d511f2d033576c6f38fa24922f"
  ]
}
