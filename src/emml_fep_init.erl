%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML init function frontend code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_fep_init).

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

gen(#{remote_node := undefined} = State) ->
    Path = get_emml_app_path(State),
    io_lib:format(
"\'_init\'(_Args) -> 
    code:add_path(\"~s\").\n", [Path]);
gen(_State) ->
    io_lib:format(
"\'_init\'(_Args) -> 
    net_kernel:start([name(), longnames]),
    erlang:set_cookie(name(), cookie()).\n", []).

%%%===================================================================
%%% Internal functions
%%%===================================================================

get_emml_app_path(State) ->
    Name = emml_utils:get_opts(emml_app, State),
    code:lib_dir(Name, ebin).
    
