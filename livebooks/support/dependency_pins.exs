# One published dependency snapshot for both Mix and fresh Livebook runtimes.
%{
  selecto: [
    git: "git@github.com:seeken/selecto.git",
    ref: "75d5289a51c0fe6949f78872fd5845b301261059"
  ],
  selecto_db_postgresql: [
    git: "git@github.com:seeken/selecto_db_postgresql.git",
    ref: "ff7061f39dbc57836e3f4df706ddac7a3e363246"
  ],
  selecto_components: [
    git: "git@github.com:seeken/selecto_components.git",
    ref: "995edfbc4dc0c0402fe02148006752c4a7f208d9"
  ]
}
