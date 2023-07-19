defmodule PokelixirTest do
  use ExUnit.Case
  doctest Pokelixir
  alias Pokelixir.Pokemon

  @tag :external
  test "get/1" do
    assert Pokelixir.get("charizard") == %Pokemon{
             id: 6,
             name: "charizard",
             hp: 78,
             attack: 84,
             defense: 78,
             special_attack: 109,
             special_defense: 85,
             speed: 100,
             height: 17,
             weight: 905,
             types: ["fire", "flying"]
           }
  end

  test "pokemon_from_json/1" do
    json = File.read!("pokemon.json")

    result = Pokelixir.pokemon_from_json(json)
    assert result.id == 6
    assert result.name == "charizard"
    assert result.hp == 78
    assert result.attack == 84
    assert result.defense == 78
    assert result.special_attack == 109
    assert result.special_defense == 85
    assert result.speed == 100
    assert result.height == 17
    assert result.weight == 905
    assert result.types == ["fire", "flying"]
  end
end
