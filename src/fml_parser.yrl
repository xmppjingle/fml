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

Nonterminals params param call calls body declare script.
Terminals ',' '(' ')' '{' '}' '.' '=' str atom fun.
Rootsymbol script.

script -> call : ['$1'] .
script -> declare : ['$1'] .
script -> script call : '$1' ++ ['$2'] .
script -> script declare : '$1' ++ ['$2'] .

declare -> fun atom '(' params ')' body  : {declare, extract_token('$2'), '$4', '$6'} .

call -> atom '(' params ')' body  : {function, extract_token('$1'), '$3', '$5'} .

body -> '{' calls '}' : '$2' .
body -> '.' calls : '$2' .
body -> '$empty' : [] .

param -> str : {'unnamed', extract_token('$1') }.
param -> atom : {'unnamed', {bind, extract_token('$1') }}.
param -> atom '=' atom : {extract_token('$1'), {bind, extract_token('$3')}}.
param -> atom '=' str : {extract_token('$1'), extract_token('$3')}.

params -> '$empty' : [].
params -> param : ['$1'] .
params -> params ',' param : '$1' ++ ['$3'] .

calls -> '$empty' : [].
calls -> call : ['$1'] .
calls -> calls '.' call : '$1' ++ ['$3'] .
calls -> calls call : '$1' ++ ['$2'] .
calls -> calls declare : '$1' ++ ['$2'] .

Erlang code.

extract_token({_Token, Value, _Line}) -> Value.
