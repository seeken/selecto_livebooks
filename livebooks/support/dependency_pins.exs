# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "c7d5f9716975defcdf81062de0a164b268d9cabe"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "f778be7304996c8f2821b123e1af30d00d4881bc"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "1f15ed5f9289d2fd04bf1799d6db7d50096d03bf"
  ]
}
