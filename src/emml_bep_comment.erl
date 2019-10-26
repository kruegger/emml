%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%     eMML backend comment code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_bep_comment).

%% API
-export([gen/1]).

%%%===================================================================
%%% API
%%%===================================================================

gen(#{name := Name} = State) ->
    HeaderFile = emml_utils:header_name(Name, State),
    '_gen'(file:eval(HeaderFile), HeaderFile).

%%--------------------------------------------------------------------
%% @doc
%% @spec
%% @end
%%--------------------------------------------------------------------

%%%===================================================================
%%% Internal functions
%%%===================================================================

'_gen'(ok, HeaderFile) ->
    {ok, Binary} = file:read_file(HeaderFile),
    binary_to_list(Binary);
'_gen'({error, _}, _) ->
    default().


default() ->
"%%%-------------------------------------------------------------------\
%%% @author  
%%% @copyright (C) 
%%% @doc\
%%%     \
%%% @end\
%%% Created : <DATE> by <EMAIL>\
%%%-------------------------------------------------------------------\
\
%%% -*- erlang -*-\n".
