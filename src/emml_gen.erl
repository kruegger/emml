%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML escript code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_gen).

-include("emml.hrl").

%% API
-export([start/1, start/2, stop/1]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

start([SpecFile, Options]) ->
    SpecName = emml_utils:spec_name(SpecFile, Options),
    OptTerms = emml_utils:string_to_term(Options), 
    start(SpecName, OptTerms).

start(SpecName, Options) ->
    io:format("Generating ~s ~p~n",[SpecName, Options]),
    S1 = emml_utils:parse_opts(Options, #{remote_node => undefined,
                                          comment => undefined,
                                          noinput => false,
                                          emml_app => ?DEFAULT_EMML_APP}),

    SpecFile = emml_utils:spec_file(SpecName, S1),

    {ok, S2} = emml_spec:parse(SpecFile, S1),

    ok = emml_frontend:create(SpecName, S2),
    ok = emml_backend:create(SpecName, S2),

    stop(S2).

stop(#{noinput := true}) -> halt(0);
stop(_State) -> ok.


%%%===================================================================
%%% Internal functions
%%%===================================================================
