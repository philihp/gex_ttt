defmodule GexTtt.Displayer do
  alias GexTtt.Context

  def display(context = %Context{view: view}) do
    IO.puts(" #{cell(view.cell00)} | #{cell(view.cell01)} | #{cell(view.cell02)} ")
    IO.puts("---+---+---")
    IO.puts(" #{cell(view.cell10)} | #{cell(view.cell11)} | #{cell(view.cell12)} ")
    IO.puts("---+---+---")
    IO.puts(" #{cell(view.cell20)} | #{cell(view.cell21)} | #{cell(view.cell22)} ")
    context
  end

  defp cell(nil) do
    " "
  end

  defp cell(0) do
    "O"
  end

  defp cell(1) do
    "X"
  end
end
