#!/usr/bin/env bats

load test_helper

setup() {
  $BIN --port "$PORT" &
  pid=$!
}

teardown() {
  kill -9 $pid
  sleep 0
}

name="ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd.ccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc.bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb.aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"

@test "dig largest A record question (plain DNS)" {
  run dig +tries=1 +time=1 -p $PORT @127.0.0.1 $name A +noedns +noall +answer +comments
  [ "$status" -eq 0 ]
  [[ "$output" == *"status: NOERROR,"* ]]
}

@test "dig largest A record question (plain EDNS)" {
  run dig +tries=1 +time=1 -p $PORT @127.0.0.1 $name A +edns=0 +noall +answer +comments
  [ "$status" -eq 0 ]
  [[ "$output" == *"status: NOERROR,"* ]]
}

@test "dig largest AAAA record question (plain DNS)" {
  run dig +tries=1 +time=1 -p $PORT @127.0.0.1 $name AAAA +noedns +noall +answer +comments
  [ "$status" -eq 0 ]
  [[ "$output" == *"status: NOERROR,"* ]]
}

@test "dig largest AAAA record question (plain EDNS)" {
  run dig +tries=1 +time=1 -p $PORT @127.0.0.1 $name AAAA +edns=0 +noall +answer +comments
  [ "$status" -eq 0 ]
  [[ "$output" == *"status: NOERROR,"* ]]
}
