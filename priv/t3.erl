%%%-----------------------------------------------------------------------------
%%% TEST 3
%%%-----------------------------------------------------------------------------

-module(pipe_test).
-compile({parse_transform, pipe_pt}).
-export([test/0]).
test() -> [[1,2,3], '|>', length].


 [{attribute,1,file,{"src/pipe_test.erl",1}},
 {attribute,1,module,pipe_test},
 {attribute,3,export,[{test,0}]},
 {function,4,test,0,
     [{clause,4,[],[],
          [{cons,4,
               {cons,4,
                   {integer,4,1},
                   {cons,4,{integer,4,2},{cons,4,{integer,4,3},{nil,4}}}},
               {cons,4,{atom,4,'|>'},{cons,4,{atom,4,length},{nil,4}}}}]}]},
 {eof,4}]

%%%=============================================================================
%%%=============================================================================

-module(pipe_test).
-compile({parse_transform, pipe_pt}).
-export([test/0]).
test() -> pipe:'|>'([1,2,3], length).


[{attribute,1,file,{"src/pipe_test.erl",1}},
 {attribute,1,module,pipe_test},
 {attribute,3,export,[{test,0}]},
 {function,4,test,0,
     [{clause,4,[],[],
          [{call,4,
               {remote,4,{atom,4,pipe},{atom,4,'|>'}},
               [{cons,4,
                    {integer,4,1},
                    {cons,4,{integer,4,2},{cons,4,{integer,4,3},{nil,4}}}},
                {atom,4,length}]}]}]},
 {eof,4}]

%%%=============================================================================
%%% analysis
%%%=============================================================================

{cons,4,{cons,4,{integer,4,1},{cons,4,{integer,4,2},{cons,4,{integer,4,3},{nil,4}}}},{cons,4,{atom,4,'|>'},{cons,4,{atom,4,length},{nil,4}}}}
{call,4,{remote,4,{atom,4,pipe},{atom,4,'|>'}},[{cons,4,{integer,4,1},{cons,4,{integer,4,2},{cons,4,{integer,4,3},{nil,4}}}},{atom,4,length}]}

{cons,4,ARG,{cons,4,{atom,4,'|>'},{cons,4,FUN,{nil,4}}}}
{call,4,{remote,4,{atom,4,pipe},{atom,4,'|>'}},[ARG,FUN]}

ARG = {cons,4,{integer,4,1},{cons,4,{integer,4,2},{cons,4,{integer,4,3},{nil,4}}}}
FUN = {atom,4,length}