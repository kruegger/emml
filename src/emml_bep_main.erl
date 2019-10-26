%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%     eMML backend main code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_bep_main).

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

gen(#{remote_node := undefined} = _State) ->
    spec() ++
    io_lib:format("run(#{params := Params, internal := true} = _Args) -> 
    Reply = cmd(Params),
    Reply;
run(#{params := Params} = _Args) -> 
    Reply = cmd(Params),
    reply(Reply).\n", []);
gen(_State) ->
    spec() ++
    io_lib:format("run(#{params := Params, internal := true} = _Args) -> 
    Reply = cmd(Params),
    Reply;
run(#{params := Params} = _Args) -> 
    try Reply = cmd(Params), reply(Reply)
    catch
        error:E ->
            reply({error, E})
    end.\n", []).

%%%===================================================================
%%% Internal functions
%%%===================================================================

spec() ->
"%%%===================================================================\
%%% API\
%%%===================================================================\
\
%%--------------------------------------------------------------------\
%% @doc\
%% @spec\
%% @end\
%%--------------------------------------------------------------------\n".
