# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "fea61baae06e90a581a154848d5759650688c3af"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "a4a4317e86f8d1051028f8ba784d8708d145d108"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "d03238405ce2f7a925cc7da071d4bfadccca048a"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "f865626cc4f0822904d794ff31b4ad1de6f2a369"
  ]
}
