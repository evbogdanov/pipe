%%%-----------------------------------------------------------------------------
%%% TEST 4
%%%-----------------------------------------------------------------------------

-module(pipe_test).
-compile({parse_transform, pipe_pt}).
-export([test/0]).
test() -> [1, '|>', fun(X) -> X + 2 end].


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
                       {'fun',4,
                           {clauses,
                               [{clause,4,
                                    [{var,4,'X'}],
                                    [],
                                    [{op,4,'+',{var,4,'X'},{integer,4,2}}]}]}},
                       {nil,4}}}}]}]},
 {eof,4}]

%%%=============================================================================
%%%=============================================================================

-module(pipe_test).
-compile({parse_transform, pipe_pt}).
-export([test/0]).
test() -> pipe:'|>'(1, fun(X) -> X + 2 end).


[{attribute,1,file,{"src/pipe_test.erl",1}},
 {attribute,1,module,pipe_test},
 {attribute,3,export,[{test,0}]},
 {function,4,test,0,
     [{clause,4,[],[],
          [{call,4,
               {remote,4,{atom,4,pipe},{atom,4,'|>'}},
               [{integer,4,1},
                {'fun',4,
                    {clauses,
                        [{clause,4,
                             [{var,4,'X'}],
                             [],
                             [{op,4,'+',{var,4,'X'},{integer,4,2}}]}]}}]}]}]},
 {eof,4}]


%%%=============================================================================
%%% analysis
%%%=============================================================================

{cons,4,{integer,4,1},{cons,4,{atom,4,'|>'},{cons,4,{'fun',4,{clauses,[{clause,4,[{var,4,'X'}],[],[{op,4,'+',{var,4,'X'},{integer,4,2}}]}]}},{nil,4}}}}
{call,4,{remote,4,{atom,4,pipe},{atom,4,'|>'}},[{integer,4,1},{'fun',4,{clauses,[{clause,4,[{var,4,'X'}],[],[{op,4,'+',{var,4,'X'},{integer,4,2}}]}]}}]}

{cons,4,ARG,{cons,4,{atom,4,'|>'},{cons,4,FUN,{nil,4}}}}
{call,4,{remote,4,{atom,4,pipe},{atom,4,'|>'}},[ARG,FUN]}

ARG = {integer,4,1}
FUN = {'fun',4,{clauses,[{clause,4,[{var,4,'X'}],[],[{op,4,'+',{var,4,'X'},{integer,4,2}}]}]}}
