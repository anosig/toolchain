#!/bin/bash

OG_PATH="$PATH"

THIS_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
source ${THIS_DIR}/env.sh

export PREFIX="/home/michael/devel/cross_x86_64-elf"
export PATH="$PREFIX/bin:$OG_PATH"

cd $SUBMOD_DIR/binutils/ld;      $PREFIX/bin/automake;
cd $SUBMOD_DIR/gcc/libstdc++-v3; $PREFIX/bin/autoconf;

export PATH="$OG_PATH"
