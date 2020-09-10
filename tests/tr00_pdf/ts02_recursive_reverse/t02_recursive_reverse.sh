#!/bin/bash

source ../../../lib/asserts.sh

NAME=recursive

EXP=$(cat -e exp)
RES="$(./$1 -Rr | cat -e)"
ASSERT_EQUAL "$EXP" "$RES" -h

OUT_DIR="out_t02"
mkdir -p $OUT_DIR
echo "$EXP" > $OUT_DIR/exp
echo "$RES" > $OUT_DIR/res
diff $OUT_DIR/exp $OUT_DIR/res > "$OUT_DIR/diff.txt"

run_leaks_check $1 $NAME

exit $TEST_FAILED
