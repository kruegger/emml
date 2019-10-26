%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML parse_params function frontend code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_fep_params).

-compile(export_all).

%% API
-export([gen/1]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

gen(State) ->
"parse_application([V, _, _]) -> list_to_atom(V); \
parse_application(N) -> parse_application(string:tokens(N, [$-])).\
parse_component([_, V, _]) -> list_to_atom(V);\ 
parse_component(N) -> parse_component(string:tokens(N, [$-])).\
parse_opcode([_, _, V]) -> list_to_atom(V);\
parse_opcode(N) -> parse_opcode(string:tokens(N, [$-])).\n\n" ++
'_gen_params_func'(State).

%%%===================================================================
%%% Internal functions
%%%===================================================================

'_gen_params_func'(#{parameters := P}) ->
    '_gen_params_func'(P);
'_gen_params_func'([]) ->
    io_lib:format("~s\n", ['_empty_params'()]);
'_gen_params_func'([{Name, Type}|T]) ->
    L1 = io_lib:format("parse_params([[~s], Params = #{params := Acc}) ->", ['_gen_func_arg'(Name)]),
    L2 = io_lib:format("    parse_params(T, Params#{params => [{~s, ~s}|Acc]});\n", [Name, '_gen_type'(Type)]),
    [string:join([L1, L2], "\n")|'_gen_params_func'(T)].

'_gen_func_arg'([]) -> [$$,$=,$|,$P,$a,$r,$a,$m,$],$|,$T];
'_gen_func_arg'([H|T]) ->
    [$$, H, $,|'_gen_func_arg'(T)].

'_gen_type'([$s,$t,$r,$i,$n,$g]) ->
    "Param";
'_gen_type'([$i,$n,$t,$e,$g,$e,$r]) ->
    "list_to_integer(Param)";
'_gen_type'([$b,$o,$o,$l,$e,$a,$n]) ->
    "list_to_atom(Param)".
    
'_empty_params'() ->
    "parse_params([], Params) -> Params;\nparse_params(_, _) -> erlang:error(invalid_parameter).".
