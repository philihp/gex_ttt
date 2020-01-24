defmodule GexTtt.Player do
  alias GexTtt.{Context, Game, Displayer, Prompter, Actioner, Agent}

  def start do
    Game.default_state()
    |> Context.init()
    |> play()
  end

  def continue(context) do
    context
    |> Displayer.display()
    |> Prompter.prompt()
    |> Actioner.action()
    |> play
  end

  def play(context = %Context{winner: nil, terminal: true}) do
    Displayer.display(context)
    IO.puts("Winner: (draw)")
    exit(:normal)
  end

  def play(context = %Context{winner: winner, terminal: true}) do
    Displayer.display(context)
    IO.puts("Winner: #{winner}")
    exit(:normal)
  end

  def play(context = %Context{active_player: active_player}) when active_player != 0 do
    context
    |> Displayer.display()
    |> Agent.play()
    |> Actioner.action()
    |> play
  end

  def(play(context = %Context{})) do
    continue(context)
  end
end
