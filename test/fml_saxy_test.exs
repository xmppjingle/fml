defmodule FML_SaxyTest do
  use ExUnit.Case
  doctest FML_Saxy

  test "parse basic dialect" do
    a = "t(a='c','d'){ b(p1='d', p2 = 'c').onConnect()  }"

    v = "<t a=\"c\" unnamed=\"d\"><b p1=\"d\" p2=\"c\"><onConnect/></b></t>"

    assert FML_Saxy.to_xml(a) == v
  end

  test "parse basic binding dialect" do
    b = """
     	expression(a = '2', b = '3').operate()
    	.onResult('5'){ print('sum') }
    	.onResult('6'){ print('multiply') }
    	.onResult(res){ print(res) }
    """

    v = "<expression a=\"2\" b=\"3\"><operate><onResult unnamed=\"5\"><print unnamed=\"sum\"/></onResult><onResult unnamed=\"6\"><print unnamed=\"multiply\"/></onResult><onResult _res=\"{{res}}\"><print _res=\"{{res}}\"/></onResult></operate></expression>"

    assert FML_Saxy.to_xml(b) == v
  end

  test "parsin mixed functions" do
    b = """
      dial(a){ onConnect(){ record(){ stream(x){ onComplete(c) } onComplete(link){ play(url = "http://") }}}}
      """
    v = "<dial _a=\"{{a}}\"><onConnect><record><stream _x=\"{{x}}\"><onComplete _c=\"{{c}}\"/></stream><onComplete _link=\"{{link}}\"><play url=\"http://\"/></onComplete></record></onConnect></dial>"

    assert FML_Saxy.to_xml(b) == v
  end

end
