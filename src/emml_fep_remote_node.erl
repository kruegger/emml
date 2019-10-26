%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML remote_node function frontend code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_fep_remote_node).

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

gen(#{remote_node := undefined}) ->
    "";
gen(State) ->
    RemoteNode = emml_utils:get_opts(remote_node, State),
    io_lib:format("remote_node() ->\n    \'~s\'.\n", [RemoteNode]).

%%%===================================================================
%%% Internal functions
%%%===================================================================
