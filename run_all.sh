#!/bin/bash
#
# Created by Rostyslav Druzhchenko on 28.07.2020.
#
# NAME
#     run_all -- Runs all the available test runs.
#
# SYNOPSIS
#     ./run_all.sh [trXX]
#
# DESCRIPTION
#    Runs all available test runs recursively.
#
#    trXX - a specific test run. If this there is no this option there, runs
#           all the available test runs.
#

source ./scripts/helpers.sh

## Check mandatory files/folders exist
#MANDATORY_FILES="src/ inc/ inc/libmx.h Makefile"
#PATH_TO_SRC='../src/'
#./scripts/check_files_exist.sh $PATH_TO_SRC "$MANDATORY_FILES"
#
## Check if only available files/folders are in the project
#
## Check there are no unavailable functions used
#AVAILABLE_FUNCTIONS=(open write)

BIN_NAME="uls"

# ================================== BUILD ====================================
source ./scripts/build.sh
build

# ================================== TEST =====================================
source ./scripts/test_runners.sh

# Run all the tests
#
if [[ $# -eq 0 ]]; then
  TEST_RUNS=$(ls -d $PWD/tests/tr*)
  print_title "Run all the tests"
  echo
  for RUN in $TEST_RUNS; do
    if [[ $(basename $RUN) == $1* ]]; then
      run_test_run $RUN
    fi
  done
  exit
fi

KIND=$(basename $1)
TO_RUN=$PWD/tests/$1
RUNABLE_NAME="\"$(basename $TO_RUN)\""

if [[ $KIND == tr* ]]; then
  print_title "Run test run $RUNABLE_NAME" && echo
  run_test_run $TO_RUN
elif [[ $KIND == ts* ]]; then
  print_title "Run test suite $RUNABLE_NAME" && echo
  run_test_suite $TO_RUN
elif [[ $KIND == t* ]]; then
  print_title "Run test case $RUNABLE_NAME" && echo
  run_test_case $TO_RUN
else
  echo "Unknown executable: \"$TO_RUN\""
fi

# ================================== CLEAN ====================================

rm -f $BIN_NAME $LIB_INC_NAME
