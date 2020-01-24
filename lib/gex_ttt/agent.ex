defmodule GexTtt.Agent do
  alias GexTtt.{Context, State}

  def play(context = %Context{state: state}) do
    %Context{
      context
      | action:
          Enum.map(State.actions(state), fn action ->
            {minimax(State.advance(state, action)), action}
          end)
          |> Enum.max()
          |> elem(1)
    }
  end

  def minimax(state, depth \\ 0, terminal \\ false, maximizing \\ false)

  def minimax(state, _depth, true, _maximizing) do
    State.score(state)
  end

  def minimax(state, 10, _terminal, _maximizing) do
    State.score(state)
  end

  def minimax(state, depth, false, false) do
    State.actions(state)
    |> Enum.map(fn action ->
      dst = State.advance(state, action)
      minimax(dst, depth + 1, State.terminal?(dst), true)
    end)
    |> Enum.min()
  end

  def minimax(state, depth, false, true) do
    State.actions(state)
    |> Enum.map(fn action ->
      dst = State.advance(state, action)
      minimax(dst, depth + 1, State.terminal?(dst), false)
    end)
    |> Enum.max()
  end
end
