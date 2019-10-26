%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML specification parser
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_spec).

-define(NEXT, next).

-include("emml.hrl").

%% API
-export([parse/2]).

%%%===================================================================
%%% API
%%%===================================================================

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

parse(FileName, State) ->
    {ok, Fd} = file:open(FileName, [read]),
    Result = p_0(?NEXT(Fd), State#{fd => Fd, name => name(FileName)}),
    ok = file:close(Fd),
    Result.
    

%%%===================================================================
%%% Internal functions
%%%===================================================================

p_0(eof, _S) -> error;
p_0([$\n|_], #{fd := Fd} = S) -> 
    p_0(?NEXT(Fd), S);
p_0([$C,$O,$M,$M,$A,$N,$D|_], #{fd := Fd} = S) ->
    p_1(?NEXT(Fd), S).

p_1(eof, _S) -> error;
p_1([$\n|_], #{fd := Fd} = S) -> p_1(?NEXT(Fd), S);
p_1([$D,$E,$S,$C,$R,$I,$P,$T,$I,$O,$N|_], #{fd := Fd} = S) -> p_2(?NEXT(Fd), S#{description => []});
p_1(Line, #{fd := Fd} = S) -> p_1(?NEXT(Fd), S#{command => strip_nl(Line)}).

p_2(eof, _S) -> error;
p_2([$\n|_], #{fd := Fd} = S) -> p_2(?NEXT(Fd), S);
p_2([$P,$A,$R,$A,$M,$E,$T,$E,$R,$S|_], #{fd := Fd} = S) -> p_3(?NEXT(Fd), S#{parameters => []});
p_2(Line, #{fd := Fd, description := D} = S) -> p_2(?NEXT(Fd), S#{description => D ++ Line}).

p_3(eof, S) -> {ok, S};
p_3([$\n|_], #{fd := Fd} = S) -> p_3(?NEXT(Fd), S);
p_3(Line, #{fd := Fd, parameters := Ps} = S ) -> 
    case [strip_ws(strip_nl(X)) || X <- re:split(Line, ":", [{return, list}, {parts, 3}])] of 
        [P1, P2, _] -> p_3(?NEXT(Fd), S#{parameters => [{P1, P2}|Ps]});
        _ -> {ok, S}
    end.

name(FileName) -> string:to_lower(filename:basename(FileName, ?EMML_SPEC_EXT)).

strip_ws({ok, S}) -> string:strip(S, both);
strip_ws(S) when is_list(S) -> string:strip(S, both);
strip_ws(S) -> S.

strip_nl(S) when is_list(S) ->  '_strip_nl'(lists:reverse(S)).
'_strip_nl'([$\n|T]) -> '_strip_nl'(T);
'_strip_nl'(S) -> lists:reverse(S).

next(Fd) -> strip_ws(file:read_line(Fd)).
