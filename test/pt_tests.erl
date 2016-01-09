-module(pt_tests).

-include_lib("eunit/include/eunit.hrl").

-compile({parse_transform, pipe_pt}).

%% BIFS
%% -----------------------------------------------------------------------------

one_fun_test() ->
	X = [1,
		'|>',
		integer_to_list],
	?assertEqual("1", X).

two_funs_test() ->
	X = [[a, b],
		'|>',
		length,
		integer_to_binary],
	?assertEqual(<<"2">>, X).

three_funs_test() ->
	X = [{a, b, c, d},
		'|>',
		tuple_to_list,
		tl,
		length],
	?assertEqual(3, X).

arg_var_test() ->
	T = {a, b},
	X = [T,
		'|>',
		size],
	?assertEqual(2, X).

arg_modfun_test() ->
	X = [lists:seq(1, 2),
		'|>',
		length],
	?assertEqual(2, X).

inside_fun_test() ->
	Fun = fun() ->
		[1,
		'|>',
		integer_to_list]
	end,
	?assertEqual("1", Fun()).

local_fun() ->
	[1, 2].
local_fun_test() ->
	X = [local_fun(),
		'|>',
		length],
	?assertEqual(2, X).

deep_inside_test() ->
	X = case 1 > 0 of
		false -> error;
		true ->
			if
				0 > 1 -> error;
				true ->
					[1,
					'|>',
					integer_to_list]
			end
	end,
	?assertEqual("1", X).

%% FUNS
%% -----------------------------------------------------------------------------

fun1_test() ->
	X = [1,
		'|>',
		fun(Y) -> Y + 1 end],
	?assertEqual(2, X).

fun2_test() ->
	X = [1,
		'|>',
		fun(Y) -> Y + 1 end,
		fun(Z) -> Z * 2 end],
	?assertEqual(4, X).

fun4_test() ->
	X = [[{a, 1}, {b, 2}],
		'|>',
		fun maps:from_list/1,
		fun maps:values/1,
		fun(Vals) -> [3 | Vals] end,
		fun lists:sum/1],
	?assertEqual(6, X).

bif_and_fun_test() ->
	X = [1,
		'|>',
		integer_to_binary,
		fun(B) -> <<"X is ", B/binary >> end,
		binary_to_list],
	?assertEqual("X is 1", X).

many_funs_test() ->
	X1 = 1,
	X2 = (fun(X) -> X + 1 end)(X1),
	X3 = (fun(X) -> X * 2 end)(X2),
	X4 = (fun(X) -> X / 3 end)(X3),
	X = [X1,
		'|>',
		fun(X) -> X + 1 end,
		fun(X) -> X * 2 end,
		fun(X) -> X / 3 end],
	?assertEqual(X4, X).

%% {MOD, FUN}
%% -----------------------------------------------------------------------------

modfun_test() ->
	X = [[{a, 1}, {b, 2}],
		'|>',
		{maps, from_list},
		{maps, keys},
		{lists, reverse}],
	?assertEqual([b, a], X).

bif_and_modfun_test() ->
	X = ['pipe me',
		'|>',
		atom_to_list,
		{string, to_upper},
		list_to_atom],
	?assertEqual('PIPE ME', X).
