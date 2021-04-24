defmodule FML do
  @moduledoc """
  Documentation for `FML`.
  """

  @doc """
  Basic Parsing.

  ## Examples

    iex> a = "t(a='c','d'){ b(p1='d', p2 = 'c').onConnect()  }"
    iex> v = {:function, 't', [{'a', 'c'}, {:unamed, 'd'}], [ {:function, 'b', [{'p1', 'd'}, {'p2', 'c'}], [{:function, 'onConnect', [], []}]} ]}
    iex> v === FML.parse(a)
    true

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
