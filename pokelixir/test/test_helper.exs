ExUnit.start()

Mox.defmock(Pokelixir.MockPokemonAPI, for: Pokelixir.PokemonAPI)
ExUnit.configure(exclude: [:slow])
Application.put_env(:pokelixir, :pokemon_api, Pokelixir.MockPokemonAPI)
