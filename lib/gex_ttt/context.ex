defmodule GexTtt.Context do
  alias GexTtt.{State, Context, Game}

  defstruct [
    :state,
    :active_player,
    :terminal,
    :winner,
    :view,
    :actions,
    :action
  ]

  def init(state = %State{}) do
    %Context{
      state: state,
      terminal: State.terminal?(state),
      active_player: State.active_player(state),
      view: Game.view(state),
      actions: State.actions(state)
    }
  end
end
