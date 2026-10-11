# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "f459fbf0a4fc2ef0c35f72216765d6d4b6579b3d"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "36bf3fe0f90d2c4c388d451c09cae88f0c8e918c"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "5180183585b3d6cb84b850b2526fb6642616f5a5"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "b600702ff8613d2faaab3f35053a17727affc131"
  ]
}
