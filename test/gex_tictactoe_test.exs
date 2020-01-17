defmodule GexTttTest do
  use ExUnit.Case
  doctest GexTtt

  test "default game not over" do
    ds = GexTtt.Game.default_state()
    assert GexTtt.State.terminal?(ds) == false
  end

  test "default game no winner" do
    ds = GexTtt.Game.default_state()
    assert GexTtt.State.winner(ds) == nil
  end

  test "terminal state is over" do
    ts =
      GexTtt.Game.default_state()
      |> GexTtt.State.advance(:cell01)
      |> GexTtt.State.advance(:cell11)
      |> GexTtt.State.advance(:cell21)
      |> GexTtt.State.advance(:cell22)
      |> GexTtt.State.advance(:cell11)

    assert GexTtt.State.terminal?(ts) == true
  end

  test "terminal state has winner" do
    ts =
      GexTtt.Game.default_state()
      |> GexTtt.State.advance(:cell01)
      |> GexTtt.State.advance(:cell11)
      |> GexTtt.State.advance(:cell21)
      |> GexTtt.State.advance(:cell22)
      |> GexTtt.State.advance(:cell11)

    assert GexTtt.State.winner(ts) == 0
  end
end
