#!/bin/bash
#
# Created by Rostyslav Druzhchenko on 28.07.2020.
#

declare function print_fail
declare function run_test_suite
declare function run_test_case

# ================================= Main ======================================

function run_test_run() {
  if [ "$#" -ne 1 ]; then
    echo "usage: run_test_run [test run full path]"
  fi

  print_delim "="

  echo "TEST RUN:" $(basename $1)
  print_delim "-"
  echo

  TEST_SUITES=$(ls -d $1/ts*)
  for SUITE in $TEST_SUITES; do
    run_test_suite $SUITE
  done
  print_delim "="
  echo
}

function run_test_suite() {
  echo "Test suite "$(basename $1)":"

  TEST_CASES=$(ls -f $1/t*)
  for CASE in $TEST_CASES; do
    run_test_case $CASE
  done

  echo
}

function run_test_case() {
  CASE=$1
  CASE_DIR=$(dirname $CASE)
  cp $PWD/$BIN_NAME $CASE_DIR
  cd $CASE_DIR
  RES="$($CASE $BIN_NAME)"
  TEST_FAILED=$?
  printf " --- "$(basename $CASE)" | "
  if [[ $TEST_FAILED -eq 0 ]]; then
    tl_print_success "OK"
  else
    print_fail "$RES"
  fi
  rm -f $CASE_DIR/$BIN_NAME
  cd ../../..
}

# =============================== Helpers =====================================

function print_fail() {
  tl_print_error "FAILED"
  echo "$1" >failed.txt
  while IFS= read -r line; do
    echo "      $line"
  done <"failed.txt"
  rm failed.txt
}
