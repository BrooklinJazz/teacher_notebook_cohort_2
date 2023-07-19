defmodule Pokelixir.PokemonAPI do
  @callback get(String.t()) :: Pokelixir.Pokemon.t()
  @callback all(integer()) :: Pokelixir.Pokemon.t()
  def all(limit \\ 10000), do: impl().all(limit)
  def get(name), do: IO.inspect(impl()).get(name)
  defp impl, do: Application.get_env(:pokelixir, :pokemon_api, Pokelixir.ExternalPokemonAPI)
end

defmodule Pokelixir.ExternalPokemonAPI do
  require Logger
  @behaviour Pokelixir.PokemonAPI

  @impl true
  def all(limit) do
    Finch.build(:get, "https://pokeapi.co/api/v2/pokemon?limit=#{limit}")
    |> Finch.request!(Pokelixir.Finch)
  end

  @impl true
  def get(name) do
    Logger.info("retrieving #{name}")

    Finch.build(:get, "https://pokeapi.co/api/v2/pokemon/#{name}")
    |> Finch.request!(Pokelixir.Finch)
  end
end
