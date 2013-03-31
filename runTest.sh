#!/bin/bash

ext="${2:-0}"
file=./tsv/$1.$ext.tsv

./server.coffee $1 &
pid=$!
echo pid: $pid

sleep 2

echo 'starting'

autobench --single_host --host1 localhost -port1 8080 --uri1 /      \
          --low_rate 10 --high_rate 90 --rate_step 10 --num_call 10 \
          --const_test_time 10 --timeout 9 --file $file \

kill $pid

say finished

cat $file
