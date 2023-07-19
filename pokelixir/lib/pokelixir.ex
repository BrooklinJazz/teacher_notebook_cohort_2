defmodule Pokelixir do
  @moduledoc """
  Documentation for `Pokelixir`.
  """
  alias Pokelixir.Pokemon

  def get(name) do
    %Finch.Response{body: body} =
      Finch.build(:get, "https://pokeapi.co/api/v2/pokemon/#{name}")
      |> Finch.request!(Pokelixir.Finch)

    pokemon_from_json(body)
  end

  def pokemon_from_json(json) do
    map = Jason.decode!(json)

    pokemon = %Pokemon{
      name: map["name"],
      id: map["id"],
      height: map["height"],
      weight: map["weight"]
    }

    pokemon =
      Enum.reduce(map["stats"], pokemon, fn stat, acc ->
        field = String.to_existing_atom(String.replace(stat["stat"]["name"], "-", "_"))
        Map.put(acc, field, stat["base_stat"])
      end)

    Enum.reduce(map["types"], pokemon, fn type, acc ->
      Map.put(acc, :types, acc.types ++ [type["type"]["name"]])
    end)
  end
end
