# JavaParser
A zero-dependency Elixir library for parsing Java files. Written using leex and yecc.

## Work in Progress
This is just a work-in-progress and is not meant for real world usage (at least for now).

## Installation
TBD

## Usage
TBD

## Development
### Building
Mix will automatically parse the lexer and parser rules at [./src/java_parser_lexer.xrl](./src/java_parser_lexer.xrl) and [./src/java_parser_parser.yrl](./src/java_parser_parser.yrl) and turn them into Erlang modules under the same directory.

In both cases Mix will use the filenames to name the modules so the lexer will be called `java_parser_lexer` and the parser will be called `java_parser_parser`, which will allow us to interact with them like any other Erlang module from our Elixir code (e.g. `:java_parser_lexer.string(...)`)

### Testing
You can simply run the `test` task. No additional steps necessary

```bash
$ mix test
```

## License
MIT

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/java_parser>.

