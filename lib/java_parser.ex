defmodule JavaParser do
  def parse(input) do
    {:ok, tokens, _line} = input |> String.to_charlist() |> :java_parser_lexer.string()
    :java_parser_parser.parse(tokens)
  end

  def parse!(input), do: input |> parse() |> bangify!()

  defp bangify!({:ok, result}), do: result
  defp bangify!({:error, error}), do: raise(error)
  defp bangify!(other), do: other
end
