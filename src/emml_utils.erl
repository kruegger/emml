%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%     eMML utility functions
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_utils).

-include("emml.hrl").

-compile(export_all).

spec_name(FileName, _State) ->
    [Name|_] = string:tokens(filename:basename(FileName), "."),
    Name.

spec_file(Name, State) ->
    EmmlApp = get_opts(emml_app, State),
    filename:join([code:lib_dir(EmmlApp), "doc", Name ++ ?EMML_SPEC_EXT]).

header_name(_Name, State) ->
    EmmlApp = get_opts(emml_app, State),
    HeaderName = get_opts(comment, State),
    filename:join([code:lib_dir(EmmlApp), "doc", HeaderName]).

frontend_name(Name, State) ->
    EmmlApp = get_opts(emml_app, State),
    filename:join([code:lib_dir(EmmlApp), "src", Name ++ ?EMML_FEP_EXT]).

backend_name(Name, State) ->
    EmmlApp = get_opts(emml_app, State),
    filename:join([code:lib_dir(EmmlApp), "src", Name ++ ?EMML_BEP_EXT]).

parse_opts([], Acc) -> Acc;
parse_opts([{noinput, V}|T], Acc) ->
    parse_opts(T, Acc#{noinput => V});
parse_opts([{remote_node, V}|T], Acc) ->
    parse_opts(T, Acc#{remote_node => V});
parse_opts([{local_node, V}|T], Acc) ->
    parse_opts(T, Acc#{local_node => V});
parse_opts([{cookie, V}|T], Acc) ->
    parse_opts(T, Acc#{cookie => V});
parse_opts([{shebang, V}|T], Acc) ->
    parse_opts(T, Acc#{shebang => V});
parse_opts([{comment, V}|T], Acc) ->
    parse_opts(T, Acc#{comment => V});
parse_opts([{emml_app, V}|T], Acc) when is_atom(V) ->
    parse_opts(T, Acc#{emml_app => V});
parse_opts([H|T], Acc) ->
    io:format("WARNING - unknown option ~p~n", [H]),
    parse_opts(T, Acc).

get_opts(noinput, State) ->
    maps:get(noinput, State, false);
get_opts(emml_app, State) ->
    maps:get(emml_app, State, ?DEFAULT_EMML_APP);
get_opts(shebang, State) ->
    maps:get(shebang, State, ?DEFAULT_SHEBANG);
get_opts(cookie, State) ->
    maps:get(cookie, State, ?DEFAULT_COOKIE);
get_opts(comment, State) ->
    maps:get(comment, State, undefined);
get_opts(remote_node, State) ->
    maps:get(remote_node, State, undefined);
get_opts(local_node, State) ->
    maps:get(local_node, State, ?DEFAULT_LOCAL_NODE).

make_terminal(S) when is_list(S) -> S ++ ".".

string_to_term([]) -> [];
string_to_term(TermStr) when is_list(TermStr) ->
    S = case lists:reverse(TermStr) of 
            [$.|_] ->
                TermStr;
            _ ->
                make_terminal(TermStr)
        end,
    {ok, Terms, _ } = erl_scan:string(S),
    {ok, T} = erl_parse:parse_term(Terms),
    T.
