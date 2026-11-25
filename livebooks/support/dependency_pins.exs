# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "41abd7292a42f7464d9eeb815a9d7fbd292c2dfa"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "3331588480051ff094ff94f8b4d3b8acef1be4ae"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "2f4c82d15a5f66d7b88cd8e527d436698671c9bf"
  ]
}
