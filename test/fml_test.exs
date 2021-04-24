defmodule FMLTest do
  use ExUnit.Case
  doctest FML

  test "parse basic dialect" do
    
  	a = "t(a='c','d'){ b(p1='d', p2 = 'c').onConnect()  }"

  	v = {:function, 't', [{'a', 'c'}, {:unamed, 'd'}],
			 [
			   {:function, 'b', [{'p1', 'd'}, {'p2', 'c'}],
			    	[{:function, 'onConnect', [], []}]}
			 ]}

    assert FML.parse(a) == v
  end
end
