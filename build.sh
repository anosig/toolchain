#!/bin/bash

OG_PATH="$PATH"
THIS_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)

export TARGET=x86_64-elf
export PREFIX="/home/michael/devel/cross_$TARGET"
export PATH="$PREFIX/bin:$OG_PATH"
$THIS_DIR/script/build.sh

export TARGET=x86_64-anos
export PREFIX="/home/michael/devel/cross_$TARGET"
export PATH="$PREFIX/bin:$OG_PATH"
$THIS_DIR/script/build.sh

export PATH="$OG_PATH"
