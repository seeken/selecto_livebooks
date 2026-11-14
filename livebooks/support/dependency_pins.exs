# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "4d9f2b64742640df93ba01dbf56fd2df2117581d"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "5a3be753e5561df5a95b6d66b96c0e2a1a72e9fd"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "0c11ef976cb6d4228c5a2e69b079ef6a4051fdd1"
  ]
}
