%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%     eMML backend usage function code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_bep_usage).

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

gen(#{emml_app := EmmlApp} = _State) ->
    io_lib:format("usage() ->\
    {ok, R} = file:read_file(\
                filename:join([code:lib_dir(~s), \"doc\", atom_to_list(?MODULE) ++ \"~s\"])),\
    R.\n", [EmmlApp, ?EMML_SPEC_EXT]).

%%%===================================================================
%%% Internal functions
%%%===================================================================
