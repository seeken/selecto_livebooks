# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "9e0e389b425e3f31e751d99556286b0ea7e1bc62"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "d0bed588271cfddd842cd0dc2ed7a728028910a4"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "0346465fabc9bff035d3da674d78eb1c097d8d29"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "06309eba93111c26980202b0c4db9db0403e0ff4"
  ]
}
