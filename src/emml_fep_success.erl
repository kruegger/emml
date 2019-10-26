%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML success function frontend code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_fep_success).

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
"\'_success\'() -> \
    out(\"~n\",[]),\
    out(\"~s~n~n\", [\"OK\"]).\n".

%%%===================================================================
%%% Internal functions
%%%===================================================================