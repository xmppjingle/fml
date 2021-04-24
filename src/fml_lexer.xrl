Definitions.

ALPHAN	       	= [a-zA-Z0-9]+
WHITESPACE 		= [\s\t\n\r]

Rules.

{ALPHAN}		: name_alphan(TokenChars, TokenLine).
\[            	: {token, {'[',  	TokenLine}}.
\]            	: {token, {']',  	TokenLine}}.
,             	: {token, {',',  	TokenLine}}.
\. 			  	: {token, {'.',  	TokenLine}}.
<  			  	: {token, {'<',		TokenLine}}.
>  			  	: {token, {'>',		TokenLine}}.
=  			  	: {token, {'=',		TokenLine}}.
\{            	: {token, {'{',  	TokenLine}}.
\}            	: {token, {'}',  	TokenLine}}.
\( 				: {token, {'(',		TokenLine}}.
\) 				: {token, {')',		TokenLine}}.
{WHITESPACE}+ 	: skip_token.

\"(\\.|\\\n|[^"\\])*\" : norm_str(TokenChars, TokenLen, TokenLine).
\'(\\.|\\\n|[^'\\])*\' : norm_str(TokenChars, TokenLen, TokenLine).

Erlang code.

name_alphan(N, L) ->
   	{token, {'atom',	N, L} }.

norm_str(C, Len, L) ->
    Cs1 = string:substr(C, 2, Len - 2),	%Strip quotes
    {token, {'str', Cs1, L}}.