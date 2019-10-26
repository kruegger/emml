%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%     eMML frontend code generator
%%% @end
%%% Created : 19 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_frontend).

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

    ScriptFile = emml_utils:frontend_name(SpecName, State),

    Sources = [X:gen(State) || X <- funcs()],

    SourceStr = string:join(Sources, "\n"),

    Sections = [shebang(emml_utils:get_opts(shebang, State)),
                comments(State),
                emu_args([mk_emu_args(State)]),
                source(SourceStr)],

    escript:create(ScriptFile, Sections),
    ok.

%%%===================================================================
%%% Internal functions
%%%===================================================================

funcs() ->
    [emml_fep_main,
     emml_fep_init,
     emml_fep_success,
     emml_fep_error,
     emml_fep_params,
     emml_fep_name,
     emml_fep_usage,
     emml_fep_remote_node,
     emml_fep_cookie,
     emml_fep_out,
     emml_fep_call, 
     emml_fep_audit].

shebang(#{shebang := undefined}) -> shebang;
shebang(State) -> {shebang, State}.

comments(#{comment := undefined}) -> comment;
comments(State) -> {comment, emml_bep_comment:gen(State)}.

emu_args(State) -> {emu_args, State}.

mk_emu_args(#{remote_node := undefined} = State) ->
    io_lib:format(" -sname ~s", [emml_utils:get_opts(local_node, State)]);
mk_emu_args(State) ->
    io_lib:format(" -name ~s -setcookie ~s", [emml_utils:get_opts(local_node, State),
                                              emml_utils:get_opts(cookie, State)]).

source([]) -> {source, <<>>};
source(State) -> {source, list_to_binary(State)}.
