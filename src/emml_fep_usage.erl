%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML usage function frontend code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_fep_usage).

-include("emml.hrl").

%% API
-export([gen/1]).

%%%===================================================================
%%% API
%%%===================================================================

gen(State) ->
    io_lib:format("usage() ->\n    ~s\n    out(\"~s~s\", [Reply]).\n",
                  ['_backend_func'(State), "~s", "~n"]).

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

%%%===================================================================
%%% Internal functions
%%%===================================================================

'_backend_func'(#{name := Name, remote_node := undefined}) ->
    io_lib:format("Reply = apply(\'~s\', usage, []),", [Name]);
'_backend_func'(#{name := Name}) ->
    io_lib:format("Reply = rpc:call(remote_node(), \'~s\', usage, []),", [Name]).
