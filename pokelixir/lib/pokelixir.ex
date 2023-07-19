defmodule Pokelixir do
  @moduledoc """
  Documentation for `Pokelixir`.
  """
  require Logger
  alias Pokelixir.Pokemon
  alias Pokelixir.PokemonAPI

  def all(limit \\ 10000) do
    %Finch.Response{body: body} = PokemonAPI.all(limit)

    map = Jason.decode!(body)
    # async_all(map["results"])
    Enum.map(map["results"], fn pokemon ->
      PokemonAPI.get(pokemon["name"]).body
    end)
    |> many_pokemon_from_json()
  end

  # def async_all(_results, acc \\ [])
  # def async_all([], acc), do: acc

  # def async_all(results, acc) do
  #   {something, rest} = Enum.split(results, System.schedulers_online())

  #   requests =
  #     Enum.map(something, fn pokemon ->
  #       Task.async(fn ->
  #         %Finch.Response{body: json} = PokemonAPI.get(pokemon["name"])
  #         json
  #       end)
  #     end)
  #     |> Task.await_many()

  #   async_all(rest, requests ++ acc)
  # end

  def get(name) do
    %Finch.Response{body: json} = PokemonAPI.get(name)
    pokemon_from_json(json)
  end

  def many_pokemon_from_json(json_list) do
    Enum.map(json_list, &pokemon_from_json/1)
  end

  def pokemon_from_json(json) do
    map = Jason.decode!(json)

    %Pokemon{
      name: map["name"],
      id: map["id"],
      height: map["height"],
      weight: map["weight"]
    }
    |> set_stats(map)
    |> set_types(map)
  end

  defp set_stats(pokemon, map) do
    Enum.reduce(map["stats"], pokemon, fn stat, acc ->
      field = String.to_existing_atom(String.replace(stat["stat"]["name"], "-", "_"))
      Map.put(acc, field, stat["base_stat"])
    end)
  end

  defp set_types(pokemon, map) do
    Enum.reduce(map["types"], pokemon, fn type, acc ->
      Map.put(acc, :types, acc.types ++ [type["type"]["name"]])
    end)
  end
end
