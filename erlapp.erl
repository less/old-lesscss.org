%%
%% {{appid}}.erl
%% {{appid}} entry point
%%
-module({{appid}}).

-export([start/0, start_link/0, stop/0]).

start_link() ->
    {{appid}}_sup:start_link().

start() ->
    application:start({{appid}}).

stop() ->
    application:stop({{appid}}).

