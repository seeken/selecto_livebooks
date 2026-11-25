# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "ba6d682912728880912c0dc826d6fff4e64aba3e"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "368c81a9a29bab4858dc996f4bf88651a2f6da3f"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "4a007347cd212c0f2bc98855a20c50ac55427131"
  ]
}
