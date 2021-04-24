# FML - Function Matching Lambda Dialect

This dialect intends to allow an archaic language representation (verb, adjectives, predicates), expressed in form of lambda functions.

Structure is defined as:
```shell
 	Function -> {:function, ParamList, Predicates}
 	ParamList -> [ {ParamName|unnamed, ParamValue}, ... ]
 	Predicates -> [ Function, ... ]
```

* It resembles Kotlin although with addition of declarative pattern matching syntax of function calls.

```kotlin

	expression(a = '2', b = '3').operate()
		.onResult('5'){ print('sum') }
		.onResult('6'){ print('multiply') }
	
```

## Example

```elixir
	a = "t(a='c','d'){ b(p1='d', p2 = 'c').onConnect()  }"

  	v = {:function, 't', [{'a', 'c'}, {:unnamed, 'd'}],
			 [
			   {:function, 'b', [{'p1', 'd'}, {'p2', 'c'}],
			    	[{:function, 'onConnect', [], []}]}
			 ]}

    assert FML.parse(a) == v
 ```


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `fml` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:fml, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fml](https://hexdocs.pm/fml).

