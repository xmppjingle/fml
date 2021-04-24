defmodule FMLTest do
  use ExUnit.Case
  doctest FML

  test "greets the world" do
    assert FML.hello() == :world
  end
end
