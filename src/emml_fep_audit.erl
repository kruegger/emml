%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML Audit Front End Process
%%% @end
%%% Created : 8 Feb 2019 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_fep_audit).

-include("emml.hrl").

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

gen(#{emml_app_audit := Audit}) ->
    io_lib:format("audit(Name, Args) ->
    ~s:audit(Name, Args)", [Audit]);
gen(_State) ->
    io_lib:format("~naudit(N, Args) ->
    U = os:getenv(\"USER\"),
    {ok, Fd} = file:open(\"~s\", [append]),
    {{Y,M,D},{H,Mi,S}} = calendar:local_time(),
    P = lists:map(fun(V) -> V ++ \" \" end, Args),
    Line = io_lib:format(\"~s\", [M,D,Y,H,Mi,S,U,N,P]),
    ok = file:write(Fd, Line),
    ok = file:close(Fd).", [?DEFAULT_EMML_APP_AUDIT_LOG, 
                            "~2.2.0w-~2.2.0w-~p ~2.2.0w:~2.2.0w:~2.2.0w ~s ~s ~s~n"]).


%%%===================================================================
%%% Internal functions
%%%===================================================================
