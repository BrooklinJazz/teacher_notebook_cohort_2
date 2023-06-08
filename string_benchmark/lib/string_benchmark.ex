defmodule StringBenchmark do
  @moduledoc """
  Documentation for `StringBenchmark`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> StringBenchmark.hello()
      :world

  """
  def hello do

    # {interpolation, _result} = :timer.tc(fn -> for x <- 0..1000000, do: "#{a}:#{b}" end)
    # {concatenation, _result} = :timer.tc(fn -> for x <- 0..1000000, do: a <> ":" <> b end)

    a = Enum.random(["adding more characters to the string", "oianwdoianwd", "oianwodinawd"])
    b = Enum.random(["does this change performance characteristics?", "pick something silly"])
    # {concatenation, interpolation}
    %{concat: concat, interp: interp} = Enum.reduce(1..100, %{concat: 0, interp: 0}, fn _, %{concat: concat, interp: interp} ->
      {interpolation, _result} = :timer.tc(fn -> for x <- 0..100000, do: "#{a}:#{b}" end)
      {concatenation, _result} = :timer.tc(fn -> for x <- 0..100000, do: a <> ":" <> b end)

      %{concat: concat + concatenation, interp: interp + interpolation,}
    end)


    %{concat: concat, interp: interp, winner: min(interp, concat)}
  end
end
