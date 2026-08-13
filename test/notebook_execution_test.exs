defmodule SelectoLivebooks.NotebookExecutionTest do
  use ExUnit.Case, async: false

  @moduletag :postgres
  @moduletag timeout: 300_000

  @repo_root Path.expand("..", __DIR__)
  @runner Path.join(@repo_root, "scripts/verify_notebook.exs")
  @workbooks [
    "selecto_updato_feature_tour.livemd",
    "selecto_updato_nested_writes_workbook.livemd",
    "selecto_verification_workbook.livemd"
  ]

  test "updated workbooks execute every Elixir cell" do
    elixir = System.find_executable("elixir") || flunk("elixir executable not found")
    ecosystem_mode = System.get_env("SELECTO_ECOSYSTEM_USE_LOCAL", "1")

    for workbook <- @workbooks do
      path = Path.join([@repo_root, "livebooks", workbook])

      {output, status} =
        System.cmd(elixir, [@runner, path],
          cd: @repo_root,
          env: [{"SELECTO_ECOSYSTEM_USE_LOCAL", ecosystem_mode}],
          stderr_to_stdout: true
        )

      assert status == 0, "#{workbook} failed:\n#{output}"
      assert output =~ "PASS livebooks/#{workbook}"
    end
  end
end
