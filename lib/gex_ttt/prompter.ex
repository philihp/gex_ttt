defmodule GexTtt.Prompter do
  alias GexTtt.Context

  def prompt(context = %Context{actions: actions}) do
    IO.gets(enum(actions))
    |> guard_error
    |> check_input(context)
  end

  defp enum(actions) do
    "[" <> Enum.join(actions, " ") <> "]$ "
  end

  defp guard_error(:eof) do
    exit(:normal)
  end

  defp guard_error({:error, reason}) do
    IO.puts("Game ended because #{reason}")
    exit(:normal)
  end

  defp guard_error(input) do
    String.to_atom(String.trim(input))
  end

  defp check_input(action, context = %Context{actions: actions}) do
    cond do
      action in actions ->
        Map.put(context, :action, action)

      true ->
        IO.puts("Invalid move")
        prompt(context)
    end
  end
end
