-module(pipe_pt).

-export([parse_transform/2]).

parse_transform(Forms, _Options) ->
	tf_forms(Forms).

tf_forms([]) ->
	[];
%% only interested in functions
tf_forms([{function, Line, Name, Arity, Clauses} | T]) ->
	[{function, Line, Name, Arity, tf_exp(Clauses)} | tf_forms(T)];
tf_forms([H | T]) ->
	[H | tf_forms(T)].	

tf_exp([]) ->
	[];
tf_exp([H | T]) ->
	[exp(H) | tf_exp(T)].

exp(Exp) when element(3, element(3, element(4, Exp))) =:= '|>' ->
	transformer(Exp);
exp(Exp) when is_tuple(Exp) ->
	list_to_tuple([exp(X) || X <- tuple_to_list(Exp)]);
exp(Exp) when is_list(Exp) ->
	tf_exp(Exp);
exp(Exp) ->
	Exp.

%% magic happens here
transformer({cons, L, Arg, {cons, _L2, {atom, _L3, '|>'}, Cons}}) ->
	{call, L, {remote, L, {atom, L, pipe}, {atom, L, '|>'}}, [Arg | parse_funs(Cons)]}.

parse_funs({nil, _L}) ->
	[];
parse_funs({cons, _L, Fun, Cons}) ->
	[Fun | parse_funs(Cons)].
