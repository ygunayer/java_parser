defmodule JavaParserTest do
  use ExUnit.Case
  doctest JavaParser

  test "greets the world" do
    assert JavaParser.hello() == :world
  end
end
