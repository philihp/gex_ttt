defmodule GexTtt.Agent do
  alias GexTtt.{Context, State}

  def play(context = %Context{state: state}) do
    %Context{
      context
      | action:
          State.actions(state)
          |> Enum.map(fn action ->
            Task.async(fn ->
              dst = State.advance(state, action)
              {minimax(dst, 0, State.terminal?(dst), false), action}
            end)
          end)
          |> Enum.map(fn task ->
            Task.await(task)
            |> IO.inspect()
          end)
          |> Enum.max()
          |> elem(1)
    }
  end

  def minimax(state, _depth, true, _maximizing) do
    State.score(state)
  end

  def minimax(state, 10, _terminal, _maximizing) do
    State.score(state)
  end

  def minimax(state, depth, false, false) do
    State.actions(state)
    |> Enum.map(fn action ->
      # Task.async(fn ->
      dst = State.advance(state, action)
      minimax(dst, depth + 1, State.terminal?(dst), true)
    end)
    # end)
    # |> Enum.map(fn task -> Task.await(task) end)
    |> Enum.min()
  end

  def minimax(state, depth, false, true) do
    State.actions(state)
    |> Enum.map(fn action ->
      # Task.async(fn ->
      dst = State.advance(state, action)
      minimax(dst, depth + 1, State.terminal?(dst), false)
    end)
    # end)
    # |> Enum.map(fn task -> Task.await(task) end)
    |> Enum.max()
  end
end
