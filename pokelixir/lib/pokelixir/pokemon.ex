defmodule Pokelixir.Pokemon do
  defstruct [
    :id,
    :name,
    :hp,
    :attack,
    :defense,
    :special_attack,
    :special_defense,
    :speed,
    :height,
    :weight,
    types: []
  ]
end
