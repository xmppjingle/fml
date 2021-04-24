%%
%% %CopyrightBegin%
%%
%% Copyright Thiago Rocha Camargo (rochacamargothiago@gmail.com). All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.
%%
%% %CopyrightEnd%
%%

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