defmodule FML_erl do
  @moduledoc """
  Documentation for `FML_erl`.
  """

  @doc """
  Basic to XML render.

  ## Examples

    iex> a = "x = 'a'"
    iex> FML_Saxy.to_xml(a)
    "_x = <<\\"a\\">>."

  """
  
  def to_erl(str) do
    ( for e <- FML.parse(str), do: nav(e) )
  end

  def nav({:function, name, attrs, children}) do
    to_string(name) <> "(" <>  (norm_attrs(attrs)) <> ") " 
      <> norm_children(children)
  end

  def nav({:declare, name, attrs, children}) do
    to_string(name) <> "(" <>  (norm_attrs(attrs)) <> ") -> \n" 
      <> norm_children(children) <> "."
  end

  def nav({:assign, name, {:bind, value} }) do
     to_string(name) <> " = _" <> to_string(value) <> "\n "
   end

  def nav({:assign, name, {:str, value, _} }) do
    to_string(name) <> " = \"" <> to_string(value) <> "\". "
  end

  def norm_attrs([]) do
    ""
  end

  def norm_attrs(attrs) do
    Enum.join( (for {k, v} <- attrs, do: norm_attrib(k, v)), ", " )
  end

  def norm_attrib(:unnamed, {:bind, v}) do
    to_string(v)
  end

  def norm_attrib(:unnamed, v) do
    "\"" <> to_string(v) <> "\""
  end

  def norm_attrib(k, {:bind, v}) do
    "_" <> to_string(k) <> " = " <> to_string(v)
  end

  def norm_attrib(k, v) do
    "_" <> to_string(k) <> " = \"" <> to_string(v) <> "\""
  end

  def norm_children(children) do 
    Enum.join( (for e <- children, do: nav(e) ), ",\n")
  end

end
