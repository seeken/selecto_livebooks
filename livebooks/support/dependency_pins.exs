# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "0e98d8ec85e84c80705cd3526ea8cc46f8c9e96d"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "b62aa794175da53cd4bdb24d88a130e6adc26612"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "cbffe0a3112de30e0c3df4cdca9eca2d34d9ea59"
  ]
}
