# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "cdf1c3596459a5c1b858506b0860ed54f6b036ff"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "d7bac4bce2ba0d80774b224c5d67fbe2e2ba1d43"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "2df23fe17909e94b59d180190806a6e3d405f62e"
  ]
}
