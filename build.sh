#!/bin/bash

# OG_PATH="$PATH"
THIS_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
source ${THIS_DIR}/script/env.sh

export TARGET=x86_64-anos-elf
export PREFIX="$HOME/opt/cross/$TARGET"
# export PATH="$PREFIX/bin:$PATH"
$SCRIPT_DIR/build.sh
