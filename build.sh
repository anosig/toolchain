#!/bin/bash

# OG_PATH="$PATH"
THIS_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
source ${THIS_DIR}/script/env.sh

# export TARGET=x86_64-elf
# export PREFIX="$HOME/opt/cross/$TARGET"
# $SCRIPT_DIR/build.sh

# $SCRIPT_DIR/dist_fetch.sh --clean
# $SCRIPT_DIR/dist_symlink.sh --unlink
# $SCRIPT_DIR/dist_symlink.sh
# $SCRIPT_DIR/run_autotools.sh

export TARGET=x86_64-anos-elf
export PREFIX="$HOME/opt/cross/$TARGET"
export PATH="$PREFIX/bin:$PATH"
$SCRIPT_DIR/build.sh
