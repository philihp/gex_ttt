defmodule GexTtt.Player do
  alias GexTtt.{Context, Game, State, Displayer, Prompter, Actioner}

  def start do
    Game.default_state()
    |> setup_context
    |> play()
  end

  defp setup_context(state) do
    %Context{
      state: state,
      terminal: State.terminal?(state),
      view: Game.view(state),
      actions: State.actions(state)
    }
  end

  def continue(context) do
    context
    |> Displayer.display()
    |> Prompter.prompt()
    |> Actioner.action()
    |> play
  end

  def play(context = %Context{winner: winner, terminal: true}) do
    Displayer.display(context)
    IO.puts("Winner: #{winner}")
    exit(:normal)
  end

  def play(context = %Context{}) do
    continue(context)
  end
end

# function minimax(node, depth, maximizingPlayer) is
#     if depth = 0 or node is a terminal node then
#         return the heuristic value of node
#     if maximizingPlayer then
#         value := −∞
#         for each child of node do
#             value := max(value, minimax(child, depth − 1, FALSE))
#         return value
#     else (* minimizing player *)
#         value := +∞
#         for each child of node do
#             value := min(value, minimax(child, depth − 1, TRUE))
#         return value
