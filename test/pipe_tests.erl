-module(pipe_tests).

-include_lib("eunit/include/eunit.hrl").

pipe_2_test() ->
	Want = integer_to_list(1),
	Have = pipe:'|>'(
		1,
		integer_to_list
	),
	?assertEqual(Want, Have).

pipe_3_test() ->
	Want = lists:reverse(lists:flatten([1, [2], 3])),
	Have = pipe:'|>'(
		[1, [2], 3],
		fun lists:flatten/1,
		fun lists:reverse/1
	),
	?assertEqual(Want, Have).

pipe_4_test() ->
	Want = binary_to_list(<<"this is binary: ", (integer_to_binary(1))/binary>>),
	Have = pipe:'|>'(
		1,
		integer_to_binary,
		fun(B) -> <<"this is binary: ", B/binary >> end,
		binary_to_list
	),
	?assertEqual(Want, Have).

pipe_5_test() ->
	Want = lists:sum([3 | maps:values(maps:from_list([{a, 1}, {b, 2}]))]),
	Have = pipe:'|>'(
		[{a, 1}, {b, 2}],
		fun maps:from_list/1,
		fun maps:values/1,
		fun(Vals) -> [3 | Vals] end,
		fun lists:sum/1
	),
	?assertEqual(Want, Have).

pipe_5_alt_test() ->
	Want = lists:sum([3 | maps:values(maps:from_list([{a, 1}, {b, 2}]))]),
	Have = pipe:'|>'(
		[{a, 1}, {b, 2}],
		{maps, from_list},
		{maps, values},
		fun(Vals) -> [3 | Vals] end,
		{lists, sum}
	),
	?assertEqual(Want, Have).

pipe_max_test() ->
	Want = "1",
	Have = pipe:'|>'(
		1,
		integer_to_list,
		list_to_binary,
		binary_to_integer,
		integer_to_list,
		list_to_binary,
		binary_to_integer,
		integer_to_list
	),
	?assertEqual(Want, Have).

%% max 7 piping funs for now
pipe_undef_test() ->
	?assertError(undef, pipe:'|>'(
		1,
		integer_to_list,
		list_to_binary,
		binary_to_integer,
		integer_to_list,
		list_to_binary,
		binary_to_integer,
		integer_to_list,
		list_to_binary
	)).
