defmodule JavaParserTest do
  use ExUnit.Case
  doctest JavaParser

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

  test "should parse generic class" do
    input = File.read!("test/fixtures/GenericClass.java")

    {:ok, parsed} = JavaParser.parse(input)

    assert parsed == TestData.generic_class()
  end
end
