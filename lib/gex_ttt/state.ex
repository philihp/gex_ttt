defmodule GexTtt.State do
  alias GexTtt.State

  use Gex.State

  defstruct(
    cell00: nil,
    cell01: nil,
    cell02: nil,
    cell10: nil,
    cell11: nil,
    cell12: nil,
    cell20: nil,
    cell21: nil,
    cell22: nil,
    active_player: 0
  )

  def score(state = %State{}) do
    winner(state) || 0.5
  end

  def terminal?(
        state = %State{
          cell00: c00,
          cell01: c01,
          cell02: c02,
          cell10: c10,
          cell11: c11,
          cell12: c12,
          cell20: c20,
          cell21: c21,
          cell22: c22
        }
      ) do
    (c00 != nil && c01 != nil && c02 != nil &&
       c10 != nil && c11 != nil && c12 != nil &&
       c20 != nil && c21 != nil && c22 != nil) ||
      !!winner(state)
  end

  def winner(%State{
        cell00: c00,
        cell01: c01,
        cell02: c02,
        cell10: c10,
        cell11: c11,
        cell12: c12,
        cell20: c20,
        cell21: c21,
        cell22: c22
      }) do
    (c00 == c01 && c01 == c02 && c01) ||
      (c10 == c11 && c11 == c12 && c11) ||
      (c20 == c21 && c21 == c22 && c21) ||
      (c00 == c10 && c10 == c20 && c00) ||
      (c01 == c11 && c11 == c21 && c01) ||
      (c02 == c12 && c12 == c22 && c02) ||
      (c00 == c11 && c11 == c22 && c00) ||
      (c20 == c11 && c11 == c02 && c20) || nil
  end

  def active_player(%State{active_player: active_player}) do
    active_player
  end

  def advance(src_state, action) do
    struct(src_state, %{
      action => src_state.active_player,
      active_player: rem(src_state.active_player + 1, 2)
    })
  end

  def actions(state = %State{}) do
    for col <- 0..2, row <- 0..2, Map.get(state, key(row, col)) == nil, into: [] do
      key(row, col)
    end
  end

  def feature_vector(state = %State{active_player: active_player}) do
    for col <- 0..2, row <- 0..2, into: [] do
      val = Map.get(state, key(row, col))

      (val == nil && 0.5) ||
        (val == active_player && 1.0) || 0.0
    end
  end

  defp key(row, col) do
    :"cell#{col}#{row}"
  end
end
