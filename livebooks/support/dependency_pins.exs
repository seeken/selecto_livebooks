# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "e24b60d50c1ad1741691d3f79f47a1b6dc1346ef"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "87251b8f85ca77854352ba1e85a066739c303959"
  ],
  selecto_updato: [
    git: "git@github.com:seeken/selecto_updato.git",
    ref: "b0b0fd4f496d2a1956533c3547352dbcc4186694"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "cef5ff10daa42b1ea73e5da44bd47ed68a073775"
  ]
}
