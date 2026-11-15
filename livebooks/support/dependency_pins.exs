# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "7ab4e1803ed391cb133089f782ba92b8a6d2369f"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "e54e2726e0aee5d588d96c782fe425a4bc32e3e3"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "5597a329c5955ff519b330460b24ca577fc96c7f"
  ]
}
