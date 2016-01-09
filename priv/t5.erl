%%%-----------------------------------------------------------------------------
%%% TEST 5 (2 BIFs)
%%%-----------------------------------------------------------------------------

-module(pipe_test).
-compile({parse_transform, pipe_pt}).
-export([test/0]).
test() -> [1, '|>', integer_to_list, list_to_binary].


[{attribute,1,file,{"src/pipe_test.erl",1}},
 {attribute,1,module,pipe_test},
 {attribute,3,export,[{test,0}]},
 {function,4,test,0,
     [{clause,4,[],[],
          [{cons,4,
               {integer,4,1},
               {cons,4,
                   {atom,4,'|>'},
                   {cons,4,
                       {atom,4,integer_to_list},
                       {cons,4,{atom,4,list_to_binary},{nil,4}}}}}]}]},
 {eof,4}]

%%%=============================================================================
%%%=============================================================================

-module(pipe_test).
-compile({parse_transform, pipe_pt}).
-export([test/0]).
test() -> pipe:'|>'(1, integer_to_list, list_to_binary).

[{attribute,1,file,{"src/pipe_test.erl",1}},
 {attribute,1,module,pipe_test},
 {attribute,3,export,[{test,0}]},
 {function,4,test,0,
           [{clause,4,[],[],
                    [{call,4,
                           {remote,4,{atom,4,pipe},{atom,4,'|>'}},
                           [{integer,4,1},
                            {atom,4,integer_to_list},
                            {atom,4,list_to_binary}]}]}]},
 {eof,4}]

%%%=============================================================================
%%% analysis
%%%=============================================================================

{cons,4,{integer,4,1},{cons,4,{atom,4,'|>'},{cons,4,{atom,4,integer_to_list},{cons,4,{atom,4,list_to_binary},{nil,4}}}}}
{call,4,{remote,4,{atom,4,pipe},{atom,4,'|>'}},[{integer,4,1},{atom,4,integer_to_list},{atom,4,list_to_binary}]}

{cons,4,ARG,{cons,4,{atom,4,'|>'},{cons,4,FUN1,{cons,4,FUN2,{nil,4}}}}}
{call,4,{remote,4,{atom,4,pipe},{atom,4,'|>'}},[ARG,FUN1,FUN2]}

ARG  = {integer,4,1}
FUN1 = {atom,4,integer_to_list}
FUN2 = {atom,4,list_to_binary}
