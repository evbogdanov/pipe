%%%-----------------------------------------------------------------------------
%%% TEST 2
%%%-----------------------------------------------------------------------------

-module(pipe_test).

-compile({parse_transform, pipe_pt}).

-export([test/0]).

test() ->
	[1,
	'|>',
	integer_to_list,
	list_to_binary].

%%%=============================================================================

 [{attribute,1,file,{"src/pipe_test.erl",1}},
 {attribute,1,module,pipe_test},
 {attribute,5,export,[{test,0}]},
 {function,7,test,0,
     [{clause,7,[],[],
          [{cons,8,
               {integer,8,1},
               {cons,9,
                   {atom,9,'|>'},
                   {cons,10,
                       {atom,10,integer_to_list},
                       {cons,11,{atom,11,list_to_binary},{nil,11}}}}}]}]},
 {eof,12}]

 %%%=============================================================================
 %%%=============================================================================

-module(pipe_test).

-compile({parse_transform, pipe_pt}).

-export([test/0]).

test() ->
	pipe:'|>'(1, integer_to_list, list_to_binary).

%%%=============================================================================

[{attribute,1,file,{"src/pipe_test.erl",1}},
 {attribute,1,module,pipe_test},
 {attribute,5,export,[{test,0}]},
 {function,7,test,0,
           [{clause,7,[],[],
                    [{call,8,
                           {remote,8,{atom,8,pipe},{atom,8,'|>'}},
                           [{integer,8,1},
                            {atom,8,integer_to_list},
                            {atom,8,list_to_binary}]}]}]},
 {eof,9}]

 %%------------------------------------------------------------------------------
 %% trans
 %%------------------------------------------------------------------------------

[
	{cons, 8, {integer,8,1},
		{cons, 9, {atom,9,'|>'},
			{cons,10, {atom,10,integer_to_list},
				{cons,11,{atom,11,list_to_binary},{nil,11}}
			}
		}
	}
]

%% ==>

[
	{call,8, {remote,8,{atom,8,pipe},{atom,8,'|>'}},
		[
			{integer,8,1},
			{atom,8,integer_to_list},
			{atom,8,list_to_binary}
		]
	}
]




