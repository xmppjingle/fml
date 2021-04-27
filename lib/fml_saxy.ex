import Saxy.XML

defmodule FML_Saxy do
  @moduledoc """
  Documentation for `FML_Saxy`.
  """

  @doc """
  Basic to XML render.

  ## Examples

    ##  "t(a='c','d'){ b(p1='d', p2 = 'c').onConnect(code= '200', reason=Reason)  }"

    iex> a = "t(a='c','d'){ b(p1='d', p2 = 'c').onConnect(code= '200', reason=Reason)  }"
    iex> FML_Saxy.to_xml(a)
    "<t a=\\"c\\" unnamed=\\"d\\"><b p1=\\"d\\" p2=\\"c\\"><onConnect code=\\"200\\" _reason=\\"{{Reason}}\\"/></b></t>"

    iex> a = "t(a='c','d'){ b(p1='d', p2 = 'c').onConnect(code= '200', reason)  }"
    iex> FML_Saxy.to_xml(a)
    "<t a=\\"c\\" unnamed=\\"d\\"><b p1=\\"d\\" p2=\\"c\\"><onConnect code=\\"200\\" _reason=\\"{{reason}}\\"/></b></t>"

  """
  
  def to_xml(str) do
    Saxy.encode!(
      nav(FML.parse(str))
      )
  end

  def nav({:function, name, attrs, children}) do
    element( (to_string(name)), (norm_attrs(attrs)), (for e <- children, do: nav(e) ) )
  end

  def norm_attrs([]) do
    []
  end

  def norm_attrs(attrs) do
    for {k, v} <- attrs, do: norm_attrib(k, v)
  end

  def norm_attrib(:unnamed, {:bind, v}) do
    {"_" <> to_string(v), "{{" <> to_string(v) <> "}}"}
  end

  def norm_attrib(k, {:bind, v}) do
    {"_" <> to_string(k), "{{" <> to_string(v) <> "}}"}
  end

  def norm_attrib(k, v) do
    {to_string(k), to_string(v)}
  end

end
