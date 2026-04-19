defmodule SelectoLivebooksNotebookBootstrap do
  @moduledoc false

  @project_root Path.expand("../..", __DIR__)
  @updato_root Path.expand("../../selecto_updato", __DIR__)

  def install!(extra_deps \\ []) do
    selecto_livebooks_dep = {:selecto_livebooks, path: @project_root, override: true}

    Mix.install(
      [
        selecto_livebooks_dep,
        {:kino, "~> 0.12"}
      ] ++ List.wrap(extra_deps)
    )

    IO.puts("Using SelectoLivebooks dependency: #{inspect(selecto_livebooks_dep)}")
    :ok
  end

  def updato_dep do
    if File.dir?(@updato_root) do
      {:selecto_updato, path: @updato_root, override: true}
    else
      {:selecto_updato, ">= 0.1.0 and < 0.3.0", override: true}
    end
  end
end
