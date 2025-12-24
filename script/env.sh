#!/bin/bash

export SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
export REPO_ROOT=$(cd ${SCRIPT_DIR}/../ && pwd)
export DIST_DIR=${REPO_ROOT}/dist
export PATCH_DIR=${REPO_ROOT}/patches
export SUBMOD_DIR=${REPO_ROOT}/submodule
