Nonterminals params param fun funs body.
Terminals ',' '(' ')' '{' '}' '.' '=' str atom.
Rootsymbol fun.

fun -> atom '(' params ')' body  : {function, extract_token('$1'), '$3', '$5'} .

body -> '{' funs '}' : '$2' .
body -> '.' funs : '$2' .
body -> '$empty' : [] .

param -> str : {'unnamed', extract_token('$1') }.
param -> atom '=' str : {extract_token('$1'), extract_token('$3')}.

params -> '$empty' : [].
params -> param : ['$1'] .
params -> params ',' param : '$1' ++ ['$3'] .

funs -> '$empty' : [].
funs -> fun : ['$1'] .
funs -> funs '.' fun : '$1' ++ ['$3'] .

Erlang code.

extract_token({_Token, Value, _Line}) -> Value.
