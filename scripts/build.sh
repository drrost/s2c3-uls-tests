#!/bin/bash
#
# Created by Rostyslav Druzhchenko on 28.07.2020.
#

function build() {
  print_title "Run BUILD"

  # Run the Makefile
  ROOT_DIR=$(echo $PWD)

  cd ../src/
  make
  mv ./$BIN_NAME $ROOT_DIR/
  build_error=$?
  make clean
  cd $ROOT_DIR

  if [ $build_error -ne 0 ]; then
    tl_print_error "Can't build the project"
    exit 1
  fi

  tl_print_success "BUILD succeed"
}
