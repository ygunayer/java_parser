defmodule JavaParserTest do
  use ExUnit.Case
  doctest JavaParser

  test "should parse plain class" do
    input = File.read!("test/fixtures/FooClass.java")

    {:ok, parsed} = JavaParser.parse(input)

    assert parsed == TestData.foo_class()
  end

  test "should parse plain enum" do
    input = File.read!("test/fixtures/FooEnum.java")

    {:ok, parsed} = JavaParser.parse(input)

    assert parsed == TestData.foo_enum()
  end
end
