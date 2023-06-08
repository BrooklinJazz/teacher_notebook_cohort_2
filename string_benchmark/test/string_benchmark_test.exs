defmodule StringBenchmarkTest do
  use ExUnit.Case
  doctest StringBenchmark

  test "greets the world" do
    assert StringBenchmark.hello() == :world
  end
end
