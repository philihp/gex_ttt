defmodule GexTtt.Context do
  defstruct [
    :state,
    :terminal,
    :winner,
    :view,
    :actions,
    :action
  ]
end
