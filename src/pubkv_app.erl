-module(pubkv_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

start(_Type, _Args) ->
	db_mnesia:setup_mnesia(),
	Dispatch = cowboy_router:compile([
		{'_', [
			{"/", send_file, []},
			{"/uuid", http_uuid, []},
			{"/key/:uuid/:key", http_key, []},
			{"/key/:uuid", http_key, []},
			{"/alias/:uuid", http_ro, []}
		]}
	]),
	{ok, _} =
		cowboy:start_http(my_http_listener, 100,
			[{port, 10080}],
			[{env, [{dispatch, Dispatch}]}]
		),
	pubkv_sup:start_link().

stop(_State) ->
	ok.
