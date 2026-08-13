defmodule SelectoLivebooks.NotebookVerifier do
  @moduledoc false

  def run(path) do
    path = Path.expand(path)
    source = File.read!(path)

    cells =
      Regex.scan(~r/^```elixir\s*\n(.*?)^```\s*$/ms, source, capture: :all_but_first)
      |> Enum.map(&hd/1)

    if cells == [] do
      raise ArgumentError, "no Elixir cells found in #{path}"
    end

    [setup_cell | remaining_cells] = cells
    {_setup_result, setup_binding} = Code.eval_string(setup_cell, [], file: path)

    executable_source =
      remaining_cells
      |> Enum.with_index(2)
      |> Enum.map_join("\n\n", fn {cell, index} ->
        "# Livebook cell #{index}\n#{cell}"
      end)

    Code.eval_string(executable_source, setup_binding, file: path)
    IO.puts("PASS #{Path.relative_to_cwd(path)} (#{length(cells)} Elixir cells)")
  end
end

case System.argv() do
  [path] ->
    SelectoLivebooks.NotebookVerifier.run(path)

  _ ->
    IO.puts(:stderr, "usage: elixir scripts/verify_notebook.exs PATH.livemd")
    System.halt(64)
end
