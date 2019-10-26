%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML call function frontend code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_fep_call).

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
    string:join(["call(Params, Acc) ->",
                 '_backend_func'(State)], "\n").


%%%===================================================================
%%% Internal functions
%%%===================================================================

'_backend_func'(#{name := Name, remote_node := undefined}) ->
    io_lib:format("    Reply = apply(\'~s\', run, [parse_params(Params, Acc)]),\
    case Reply of \
        {error, Reason} -> erlang:error(Reason);\
        Reply -> Reply \
    end.", [Name]);
'_backend_func'(#{name := Name}) ->
    io_lib:format("    Reply = rpc:call(remote_node(), \'~s\', run, [parse_params(Params, Acc)]),\
    case Reply of \
        {error, Reason} -> erlang:error(Reason);\
        Reply -> Reply \
    end.", [Name]).

