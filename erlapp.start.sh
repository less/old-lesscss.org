#!/bin/sh

echo Starting {{appid}} with development console..

exec erl -pa $PWD/ebin\
         -pa $PWD/deps/*/ebin\
         -pa $PWD/dev/*/ebin\
         -args_file `dirname $0`/start.args

