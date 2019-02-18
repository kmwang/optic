%%%-------------------------------------------------------------------
%%% @doc
%%% Tests for src/optic_tuples.erl
%%% @end
%%%-------------------------------------------------------------------
-module(test_optic_tuples).

-include("include/optic_tuples.hrl").
-include_lib("eunit/include/eunit.hrl").

-record(test_optic_tuples, {one=1, two=2, three=3}).

%%%===================================================================
%%% Tests
%%%===================================================================

all_get_test_() ->
    [?_assertEqual({ok, [1, 2, 3]},
                   optic:get([optic_tuples:all([strict])], {1, 2, 3})),
     ?_assertEqual({error, undefined},
                   optic:get([optic_tuples:all([strict])], atom))].

all_put_test_() ->
    [?_assertEqual({ok, {4, 4, 4}},
                   optic:put([optic_tuples:all([strict])], {1, 2, 3}, 4)),
     ?_assertEqual({error, undefined},
                   optic:put([optic_tuples:all([strict])], atom, 4))].

all_create_test() ->
    ?assertEqual({ok, {}},
                 optic:put([optic_tuples:all([strict, create])], atom, 4)).

element_get_test_() ->
    [?_assertEqual({ok, [1]},
                   optic:get([optic_tuples:element(1, [strict])], {1, 2, 3})),
     ?_assertEqual({error, undefined},
                   optic:get([optic_tuples:element(1, [strict])], atom))].

element_put_test_() ->
    [?_assertEqual({ok, {4, 2, 3}},
                   optic:put([optic_tuples:element(1, [strict])],
                             {1, 2, 3},
                             4)),
     ?_assertEqual({error, undefined},
                   optic:put([optic_tuples:element(1, [strict])],
                             atom,
                             4))].

element_create_test_() ->
    [?_assertEqual({ok, {undefined, 4}},
                   optic:put([optic_tuples:element(2, [strict,
                                                       {create, undefined}])],
                             atom,
                             4)),
     ?_assertEqual({ok, {1, undefined, 4}},
                   optic:put([optic_tuples:element(3, [strict,
                                                       {create, undefined}])],
                             {1},
                             4))].

field_get_test_() ->
    [?_assertEqual({ok, [1]},
                   optic:get([optic_tuples:field(test_optic_tuples,
                                                 record_info(size, test_optic_tuples),
                                                 #test_optic_tuples.one,
                                                 [strict])],
                             #test_optic_tuples{})),
     ?_assertEqual({ok, [1]},
                   optic:get([optic_tuples:field(?OPTIC_FIELD(test_optic_tuples, one))],
                             #test_optic_tuples{})),
     ?_assertEqual({error, undefined},
                   optic:get([optic_tuples:field(test_optic_tuples,
                                                 record_info(size, test_optic_tuples),
                                                 #test_optic_tuples.one,
                                                 [strict])],
                             {test_optic_tuples}))].

field_put_test_() ->
    [?_assertEqual({ok, {test_optic_tuples, 4, 2, 3}},
                   optic:put([optic_tuples:field(test_optic_tuples,
                                                 record_info(size, test_optic_tuples),
                                                 #test_optic_tuples.one,
                                                 [strict])],
                             #test_optic_tuples{},
                             4)),
     ?_assertEqual({ok, {test_optic_tuples, 4, 2, 3}},
                   optic:put([optic_tuples:field(?OPTIC_FIELD(test_optic_tuples, one))],
                             #test_optic_tuples{},
                             4)),
     ?_assertEqual({error, undefined},
                   optic:put([optic_tuples:field(test_optic_tuples,
                                                 record_info(size, test_optic_tuples),
                                                 #test_optic_tuples.one,
                                                 [strict])],
                             {test_optic_tuples},
                             4))].

field_create_test() ->
    ?assertEqual({ok, {test_optic_tuples, 4, undefined, undefined}},
                   optic:put([optic_tuples:field(test_optic_tuples,
                                                 record_info(size, test_optic_tuples),
                                                 #test_optic_tuples.one,
                                                 [strict, {create, undefined}])],
                             {test_optic_tuples},
                             4)).
