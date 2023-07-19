defmodule Pokelixir.Pokemon do
  @type t() :: %__MODULE__{
          id: integer(),
          name: String.t(),
          hp: integer(),
          attack: integer(),
          defense: integer(),
          special_attack: integer(),
          special_defense: integer(),
          speed: integer(),
          height: integer(),
          weight: integer()
        }

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
