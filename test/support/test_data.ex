defmodule TestData do
  def foo_class(),
    do: %{
      package: :"com.yalingunayer.java_parser",
      imports: [
        "com.yalingunayer.somepackage.SomeClass",
        "com.yalingunayer.anotherpackage.*"
      ],
      class: %{
        name: :FooClass,
        visibility: :public,
        body: [
          {:field, %{visibility: :private, type: :int, name: :id, final: false}},
          {:field, %{visibility: :private, type: :String, name: :name, final: false}},
          {:method, %{visibility: :public, returns: :int, name: :getId, args: [], body: []}},
          {:method, %{visibility: :public, returns: :String, name: :getName, args: [], body: []}}
        ]
      }
    }

  def foo_enum(),
    do: %{
      package: :"com.yalingunayer.java_parser",
      imports: [],
      enum: %{
        name: :FooEnum,
        visibility: :public,
        body: [
          {
            :enum_values,
            [
              %{name: :FOO, args: []},
              %{name: :BAR, args: []}
            ]
          }
        ]
      }
    }
end
