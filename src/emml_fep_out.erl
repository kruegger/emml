%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML out function frontend code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_fep_out).

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

gen(_State) ->
"out(Format, Args) -> \
    io:format(Format, Args).\n".

%%%===================================================================
%%% Internal functions
%%%===================================================================