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
    "<script><t a=\\"c\\" unnamed=\\"d\\"><b p1=\\"d\\" p2=\\"c\\"><onConnect code=\\"200\\" _reason=\\"Reason\\"/></b></t></script>"

    iex> a = "t(a='c','d'){ b(p1='d', p2 = 'c').onConnect(code= '200', reason)  }"
    iex> FML_Saxy.to_xml(a)
    "<script><t a=\\"c\\" unnamed=\\"d\\"><b p1=\\"d\\" p2=\\"c\\"><onConnect code=\\"200\\" _reason=\\"reason\\"/></b></t></script>"

    iex> a = "body(){ t(a='c','d'){ b(p1='d', p2 = 'c').onConnect(code= '200', reason)  } a() }"
    iex> FML_Saxy.to_xml(a)
    "<script><body><t a=\\"c\\" unnamed=\\"d\\"><b p1=\\"d\\" p2=\\"c\\"><onConnect code=\\"200\\" _reason=\\"reason\\"/></b></t><a/></body></script>"

    iex> a = "body(){ fun t(a='c','d'){ b(p1='d', p2 = 'c').onConnect(code= '200', reason)  } a() }"
    iex> FML_Saxy.to_xml(a)
    "<script><body><snippet id=\\"t\\" a=\\"c\\" unnamed=\\"d\\"><b p1=\\"d\\" p2=\\"c\\"><onConnect code=\\"200\\" _reason=\\"reason\\"/></b></snippet><a/></body></script>"

    iex> a = "fun body(){ fun t(a='c','d'){ b(p1='d', p2 = 'c').onConnect(code= '200', reason)  } a() }"
    iex> FML_Saxy.to_xml(a)
    "<script><snippet id=\\"body\\"><snippet id=\\"t\\" a=\\"c\\" unnamed=\\"d\\"><b p1=\\"d\\" p2=\\"c\\"><onConnect code=\\"200\\" _reason=\\"reason\\"/></b></snippet><a/></snippet></script>"

    iex> a = "fun body(){ fun t(a='c','d'){ b(p1='d', p2 = 'c').onConnect(code= '200', reason)  } fun a(){ fun b(){} fun c(){} d() } }"
    iex> FML_Saxy.to_xml(a)
    "<script><snippet id=\\"body\\"><snippet id=\\"t\\" a=\\"c\\" unnamed=\\"d\\"><b p1=\\"d\\" p2=\\"c\\"><onConnect code=\\"200\\" _reason=\\"reason\\"/></b></snippet><snippet id=\\"a\\"><snippet id=\\"b\\"/><snippet id=\\"c\\"/><d/></snippet></snippet></script>"

    iex> a = "x = 'a'"
    iex> FML_Saxy.to_xml(a)
    "<script><save key=\\"x\\" value=\\"a\\"/></script>"

    iex> a = "x = a"
    iex> FML_Saxy.to_xml(a)
    "<script><save key=\\"x\\" value=\\"{{a}}\\"/></script>"

  """
  
  def to_xml(str) do
    to_xml(str, "script")
  end

  def to_xml(str, root) do
    Saxy.encode!(
      element(root, [], ( for e <- FML.parse(str), do: nav(e) ))
      )
  end

  def nav({:function, name, attrs, children}) do
    element( (to_string(name)), (norm_attrs(attrs)), (for e <- children, do: nav(e) ) )
  end

  def nav({:declare, name, attrs, children}) do
    element( "snippet", [ {"id", to_string(name)} | (norm_attrs(attrs))], (for e <- children, do: nav(e) ) )
  end

  def nav({:assign, name, {:bind, value} }) do
    element( "save", [ {"key", to_string(name)} , {"value", "{{" <> to_string(value) <> "}}" } ], [] )
  end

def nav({:assign, name, {:str, value, _} }) do
    element( "save", [ {"key", to_string(name)} , {"value", to_string(value)} ], [] )
  end

  def norm_attrs([]) do
    []
  end

  def norm_attrs(attrs) do
    for {k, v} <- attrs, do: norm_attrib(k, v)
  end

  def norm_attrib(:unnamed, {:bind, v}) do
    {"_" <> to_string(v), to_string(v)}
  end

  def norm_attrib(k, {:bind, v}) do
    {"_" <> to_string(k), to_string(v)}
  end

  def norm_attrib(k, v) do
    {to_string(k), to_string(v)}
  end

end
