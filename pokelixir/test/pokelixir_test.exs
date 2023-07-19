defmodule PokelixirTest do
  use ExUnit.Case, async: true
  doctest Pokelixir

  alias Pokelixir.Pokemon
  import Mox
  @charizard_json File.read!("test/support/charizard.json")

  # Use the actual Pokemon API by default in tests.
  setup _ do
    Mox.stub_with(Pokelixir.MockPokemonAPI, Pokelixir.ExternalPokemonAPI)
    :ok
  end

  # Make sure mocks are verified when the test exits
  setup :verify_on_exit!

  @tag :external
  @tag :slow
  @tag timeout: :infinity
  test "all/1 all pokemon" do
    results = Pokelixir.all()
    assert length(results) == 1281
    assert %Pokemon{} = List.first(results)
  end

  @tag :external
  test "all/1 ten pokemon" do
    results = Pokelixir.all(10)
    assert length(results) == 10
    assert %Pokemon{} = List.first(results)
  end

  @tag :external
  test "all/1 first pokemon" do
    results = Pokelixir.all(1)
    assert length(results) == 1

    assert List.first(results) == %Pokelixir.Pokemon{
             id: 1,
             name: "bulbasaur",
             attack: 49,
             defense: 49,
             height: 7,
             hp: 45,
             special_attack: 65,
             special_defense: 65,
             speed: 45,
             types: ["grass", "poison"],
             weight: 69
           }
  end

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

  test "all/1 _ when mock API returns a single pokemon" do
    Pokelixir.MockPokemonAPI
    |> expect(:all, fn _limit ->
      %Finch.Response{body: Jason.encode!(%{results: [%{name: "charizard"}]})}
    end)
    |> expect(:get, fn "charizard" -> %Finch.Response{body: @charizard_json} end)

    assert Pokelixir.all() == [
             %Pokemon{
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
           ]
  end

  test "get/1 _ when mock API returns charizard" do
    Pokelixir.MockPokemonAPI
    |> expect(:get, fn "charizard" -> %Finch.Response{body: @charizard_json} end)

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

  test "many_pokemon_from_json/1" do
    assert Pokelixir.many_pokemon_from_json([@charizard_json, @charizard_json]) == [
             %Pokemon{
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
             },
             %Pokemon{
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
           ]
  end

  test "pokemon_from_json/1" do
    result = Pokelixir.pokemon_from_json(@charizard_json)
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
