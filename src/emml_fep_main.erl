%%%-------------------------------------------------------------------
%%% @author  Stephen Han <kruegger@gmail.com>
%%% @copyright (C) 2018 Stephen Han
%%% @doc
%%%    eMML main function frontend code generator
%%% @end
%%% Created : 17 Dec 2018 by  <kruegger@gmail.com>
%%%-------------------------------------------------------------------
-module(emml_fep_main).

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
"main(Args) ->\
    \'_init\'(Args),\
    try \'_main\'(Args), \'_success\'()\
    catch \
         error:E ->\
             usage(),\
             \'_error\'(E)\
    end.\
\
\'_main\'([\"?\"]) -> usage();\
\'_main\'([\"help\"]) -> usage();\
\'_main\'(Params) -> \
    Name = escript:script_name(),\
    Acc = #{application => parse_application(Name),\
            component => parse_component(Name),\
            opcode => parse_opcode(Name),\
            params => []},\
    audit(Name, Params),\
    out(\"~n\", []),\
    out(\"~s~n\", [\"COMMAND ACCEPTED\"]),
    Reply = call(Params, Acc),\
    out(\"~n\", []),\
    out(\"RESULT~n~n\", []),\
    out(\"    ~s~n\", [Reply]).\n".

%%%===================================================================
%%% Internal functions
%%%===================================================================
