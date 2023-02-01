defmodule TestData do
  def foo_enum() do
    %{
      enum: %{
        annotations: [%{name: "MarkerAnnotation"}],
        name: "FooEnum",
        visibility: :public,
        values: [
          %{name: "FOO"},
          %{name: "BAR", annotations: [%{args: ["foo"], name: "SomeAnnotation"}]}
        ]
      },
      imports: [],
      package: ["com", "yalingunayer", "java_parser"]
    }
  end

  def fizz_string_returner() do
    %{
      class: %{
        annotations: [%{name: "Service"}],
        body: [
          method: %{
            args: [],
            body: [
              var: %{
                final: true,
                name: "myStringBuilder",
                type: "StringBuilder",
                value: {:call, {:new, "StringBuilder", [ref: ["com", "seriouscompany", "business", "java", "fizzbuzz", "packagenamingpackage", "impl", "Constants", "FIZZ"]]}}
              },
              var: %{final: true, name: "myString", type: "String", value: {:call, {["myStringBuilder", "toString"], []}}},
              var: %{final: true, name: "myCharacters", type: {:array, "char"}, value: {:call, {["myString", "toCharArray"], []}}},
              return: {:call, {:new, "String", [{:ref, "myCharacters"}, 0, {:ref, ["myCharacters", "length"]}]}}
            ],
            name: "getReturnString",
            type: "String",
            visibility: :public
          }
        ],
        inheritance: %{implements: ["StringStringReturner"]},
        name: "FizzStringReturner",
        visibility: :public
      },
      imports: [
        ["org", "springframework", "stereotype", "Service"],
        ["com", "seriouscompany", "business", "java", "fizzbuzz", "packagenamingpackage", "interfaces", "stringreturners", "StringStringReturner"]
      ],
      package: ["com", "seriouscompany", "business", "java", "fizzbuzz", "packagenamingpackage", "impl", "stringreturners"]
    }
  end

  def vector2_class() do
    %{
      class: %{
        annotations: [%{name: "Data"}],
        body: [
          field: %{default: 1, final: true, name: "serialVersionUid", static: true, type: "int", visibility: :private},
          field: %{default: {:call, {:new, "Vector2", [0, 0]}}, final: true, name: "ZERO", static: true, type: "Vector2", visibility: :public},
          field: %{default: {:call, {:new, "Vector2", [1, 1]}}, final: true, name: "ONE", static: true, type: "Vector2", visibility: :public},
          field: %{default: {:call, {:new, "Vector2", [0, 1]}}, final: true, name: "UP", static: true, type: "Vector2", visibility: :public},
          field: %{default: {:call, {:new, "Vector2", [0, -1]}}, final: true, name: "DOWN", static: true, type: "Vector2", visibility: :public},
          field: %{default: {:call, {:new, "Vector2", [1, 0]}}, final: true, name: "RIGHT", static: true, type: "Vector2", visibility: :public},
          field: %{default: {:call, {:new, "Vector2", [-1, 0]}}, final: true, name: "LEFT", static: true, type: "Vector2", visibility: :public},
          field: %{final: true, name: "x", type: "double", visibility: :private},
          field: %{final: true, name: "y", type: "double", visibility: :private},
          method: %{args: [], body: [return: {:ref, ["this", "x"]}], name: "getX", type: "double", visibility: :public},
          method: %{args: [], body: [return: {:ref, ["this", "y"]}], name: "getY", type: "double", visibility: :public},
          method: %{
            args: [],
            body: [return: {:call, {["Math", "sqrt"], [{:-, {:*, {:ref, "y"}, {:ref, "y"}}, {:*, {:ref, "x"}, {:ref, "x"}}}]}}],
            name: "getLength",
            type: "double",
            visibility: :public
          },
          method: %{
            args: [%{final: true, name: "other", type: "Vector2"}],
            body: [return: {:call, {:new, "Vector2", [{:+, {:ref, ["this", "x"]}, {:ref, ["other", "x"]}}, {:+, {:ref, ["this", "y"]}, {:ref, ["other", "y"]}}]}}],
            name: "add",
            type: "Vector2",
            visibility: :public
          },
          method: %{
            args: [%{final: true, name: "vectors", type: {:varargs, "Vector2"}}],
            body: [
              var: %{name: "vectorList", type: {:generic, "List", ["Vector2"]}, value: {:call, {["Arrays", "asList"], [ref: "vectors"]}}},
              return: {:chain, {:call, {["vectorList", "stream"], []}}}
            ],
            name: "addAll",
            static: true,
            type: "Vector2",
            visibility: :public
          }
        ],
        inheritance: %{implements: ["Serializable"]},
        name: "Vector2",
        visibility: :public
      },
      imports: [["lombok", "Data"], ["java", "io", "Serializable"], ["java", "util", "Arrays"], ["java", "util", "List"]],
      package: ["com", "yalingunayer", "sandbox"]
    }
  end

  def generic_class() do
    %{
      class: %{
        body: [
          field: %{default: 1, final: true, name: "serialVersionUid", static: true, type: "int", visibility: :private},
          field: %{name: "id", type: "int", visibility: :private},
          field: %{name: "name", type: "String", visibility: :private},
          field: %{default: {:call, {["List", "of"], ["foo", "bar"]}}, final: true, name: "foos", type: {:generic, "List", ["String"]}, visibility: :private},
          method: %{args: [], body: [return: {:ref, ["this", "id"]}], name: "getId", type: "int", visibility: :public},
          method: %{args: [], body: [return: {:ref, ["this", "name"]}], name: "getName", type: "String", visibility: :public},
          method: %{args: [], body: [return: {:chain, {:call, {["this", "foos", "stream"], []}}}], name: "getFooFoos", type: {:generic, "List", ["String"]}, visibility: :public},
          method: %{
            args: [%{name: "a", type: "FooClass"}, %{name: "b", type: "FooClass"}],
            body: [
              var: %{name: "idA", type: "int", value: {:call, {["a", "getId"], []}}},
              var: %{name: "idB", type: "int", value: {:call, {["b", "getId"], []}}},
              return: {:call, {["Math", "max"], [ref: "idA", ref: "idB"]}}
            ],
            name: "maxId",
            type: "int",
            visibility: :public
          }
        ],
        name: {:generic, "GenericClass", ["T"]},
        visibility: :public,
        inheritance: %{name: {:generic, "GenericClass", ["T"]}, visibility: :public}
      },
      imports: [["com", "yalingunayer", "somepackage", "SomeClass"], ["com", "yalingunayer", "anotherpackage", "*"]],
      package: ["com", "yalingunayer", "java_parser"]
    }
  end
end
