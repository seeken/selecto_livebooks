# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "4c899eae66063f299447742a2327244b26d574b6"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "e1e7bd550fa8a1f8600fd4d605d1b9ce5afd077a"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "92c86c520d7130054d392f7cc12c54b7616df809"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "f3524642a4426c5a6b4fd1631733713289f4ecc9"
  ]
}
