%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%     eMML backend code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_backend).

%% API
-export([create/2]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

create(SpecName, State) ->
    BackendFile = emml_utils:backend_name(SpecName, State),
    Sources = [X:gen(State) || X <- funcs()],
    SourceStr = string:join(Sources, "\n"),
    ok = file:write_file(BackendFile, list_to_binary(SourceStr)).

%%%===================================================================
%%% Internal functions
%%%===================================================================

funcs() ->
    [ emml_bep_comment,
      emml_bep_header,
      emml_bep_main,
      emml_bep_usage,
      emml_bep_internal ].
