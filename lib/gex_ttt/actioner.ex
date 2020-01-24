defmodule GexTtt.Actioner do
  alias GexTtt.{State, Context, Game}

  def action(context = %Context{state: src_state, action: action}) do
    dst_state = State.advance(src_state, action)

    %Context{
      context
      | state: dst_state,
        action: nil,
        actions: State.actions(dst_state),
        active_player: State.active_player(dst_state),
        terminal: State.terminal?(dst_state),
        winner: State.winner(dst_state),
        view: Game.view(dst_state)
    }
  end
end
