# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "e12e3f88e29b341ef098e1b03ab7252d744d8210"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "ff7fe462ad97b067a1f5d4e2033d8d995f4ab722"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "a03804d9f2e8046eacfea799201cf34f1857eb67"
  ]
}
