-module(pipe).

-export([
	'|>'/2,
	'|>'/3,
	'|>'/4,
	'|>'/5,
	'|>'/6,
	'|>'/7,
	'|>'/8
]).

%% API
%% -----------------------------------------------------------------------------

'|>'(Arg, Fun) ->
	do_pipe(Arg, [Fun]).

'|>'(Arg, F1, F2) ->
	do_pipe(Arg, [F1, F2]).

'|>'(Arg, F1, F2, F3) ->
	do_pipe(Arg, [F1, F2, F3]).

'|>'(Arg, F1, F2, F3, F4) ->
	do_pipe(Arg, [F1, F2, F3, F4]).

'|>'(Arg, F1, F2, F3, F4, F5) ->
	do_pipe(Arg, [F1, F2, F3, F4, F5]).

'|>'(Arg, F1, F2, F3, F4, F5, F6) ->
	do_pipe(Arg, [F1, F2, F3, F4, F5, F6]).

'|>'(Arg, F1, F2, F3, F4, F5, F6, F7) ->
	do_pipe(Arg, [F1, F2, F3, F4, F5, F6, F7]).

%% IMPLEMENTATION
%% -----------------------------------------------------------------------------

do_pipe(Arg, Funs) ->
	lists:foldl(fun do_apply/2, Arg, Funs).

do_apply(Fun, Arg) when is_atom(Fun) ->
	erlang:Fun(Arg);
do_apply(Fun, Arg) when is_function(Fun) ->
	Fun(Arg);
do_apply({Mod, Fun}, Arg) when is_atom(Mod), is_atom(Fun) ->
	Mod:Fun(Arg).
