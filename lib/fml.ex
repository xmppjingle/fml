defmodule FML do
  @moduledoc """
  Documentation for `FML`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> FML.parse("test(a='b')")
      :world

  """
  def parse(str) do
    with {:ok, tokens, _} <- :fml_lexer.string(to_charlist(str)),
         {:ok, result} <- :fml_parser.parse(tokens)
    do
      result
    else
      {:error, reason, _} ->
        reason
      {:error, {_, :fml_parser, reason}} ->
        to_string(reason)
    end
  end
end
