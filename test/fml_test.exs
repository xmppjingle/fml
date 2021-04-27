defmodule FMLTest do
  use ExUnit.Case
  doctest FML

  test "parse basic dialect" do
    a = "t(a='c','d'){ b(p1='d', p2 = 'c').onConnect()  }"

    v =
      [{:function, 't', [{'a', 'c'}, {:unnamed, 'd'}],
       [
         {:function, 'b', [{'p1', 'd'}, {'p2', 'c'}], [{:function, 'onConnect', [], []}]}
       ]}]

    assert FML.parse(a) == v
  end

  test "parse basic binding dialect" do
    b = """
     	expression(a = '2', b = '3').operate()
    	.onResult('5'){ print('sum') }
    	.onResult('6'){ print('multiply') }
    	.onResult(res){ print(res) }
    """

    v =
      [{:function, 'expression', [{'a', '2'}, {'b', '3'}],
       [
         {:function, 'operate', [],
          [
            {:function, 'onResult', [unnamed: '5'], [{:function, 'print', [unnamed: 'sum'], []}]},
            {:function, 'onResult', [unnamed: '6'],
             [{:function, 'print', [unnamed: 'multiply'], []}]},
            {:function, 'onResult', [unnamed: {:bind, 'res'}],
             [{:function, 'print', [unnamed: {:bind, 'res'}], []}]}
          ]}
       ]}]

    assert FML.parse(b) == v
  end
end
