defmodule JavaParserTest do
  use ExUnit.Case
  doctest JavaParser

  test "should parse plain class" do
    input = File.read!("test/fixtures/FooClass.java")

    {:ok, parsed} = JavaParser.parse(input)

    assert parsed == TestData.foo_class()
  end

  test "should parse Vector2 class" do
    input = File.read!("test/fixtures/Vector2.java")

    {:ok, parsed} = JavaParser.parse(input)

    assert parsed == TestData.vector2_class()
  end

  test "should parse plain enum" do
    input = File.read!("test/fixtures/FooEnum.java")

    {:ok, parsed} = JavaParser.parse(input)

    assert parsed == TestData.foo_enum()
  end

  test "should parse enterprise fizz buzz class" do
    input = File.read!("test/fixtures/FizzString.java")

    {:ok, parsed} = JavaParser.parse(input)

    assert parsed == TestData.fizz_string_returner()
  end
end
