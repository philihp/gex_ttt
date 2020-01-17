defmodule GexTtt.Game do
  @behaviour Gex.Game

  alias GexTtt.State

  def default_state do
    %State{}
  end

  def view(state) do
    state
  end
end
