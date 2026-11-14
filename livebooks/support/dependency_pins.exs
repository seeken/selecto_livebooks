# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "cdf1c3596459a5c1b858506b0860ed54f6b036ff"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "d0b1745040613a2be7ef35861218f0bebb6a99c9"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "ed47e8c28d590b0edde7cdd62cfebb687a2743dd"
  ]
}
