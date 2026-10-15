# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "c0e2a41beb8a60c869960c73f3aab5e7dd493ca0"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "fbdfb0b311a9d845cc1e5d156f18e4f48bc8ae90"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "d29cad181b489c86e10bb5362e37947a2dcc041b"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "7b3a6483acbf3966899d48966e528aee184e74c0"
  ]
}
