#!/bin/bash

export SCRIPT_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
export REPO_ROOT=$(cd ${SCRIPT_DIR}/../ && pwd)
export DIST_DIR=${REPO_ROOT}/dist
export PATCH_DIR=${REPO_ROOT}/patch
export SUBMOD_DIR=${REPO_ROOT}/submodule

if [[ "$ANOS_SHLVL" == "" ]]; then
    export ANOS_SHLVL=0
else
    ((ANOS_SHLVL++))
fi

patch_dist()
{
    name=$1
    dir=$2

    while [ "$#" -gt 0 ]; do
        case "$1" in
            --name=*)
                name="${1#*=}"
                ;;
            --path=*)
                dir="${1#*=}"
                ;;
            *)
                echo "Error: Invalid argument $1"
                exit 1
                ;;
        esac
        shift
    done

    export PREFIX="$HOME/opt/cross/x86_64-linux-gnu"
    export PATH="$PREFIX/bin:$PATH"
    cd $DIST_DIR/$name
    patch -p1 < "${PATCH_DIR}/binutils-2.45.patch"
    cd ./ld && $PREFIX/bin/automake
}



export ANOS_TARGET="x86_64-anos-elf"
export ANOS_PREFIX="$HOME/opt/cross"

anSetGCC()
{
    while [[ "$1" != "" ]]; do
        case "$1" in
            -t | --target )
                ANOS_TARGET="$2"
                shift
                shift
                ;;
            -p | --prefix )
                ANOS_PREFIX="$2"
                shift
                shift
                ;;
            *)
                echo "Error: Invalid argument $1"
                exit 1
                ;;
        esac
        shift
    done

    if [[ ! -d "$ANOS_PREFIX/$ANOS_TARGET" ]]; then
        echo "ERROR: Directory not found: $ANOS_PREFIX/$ANOS_TARGET"
        exit 0
    fi

    export PATH="${ANOS_PREFIX}/${ANOS_TARGET}/bin:${PATH}"
}

anosenv()
{
    ((ANOS_SHLVL++))
    export -f anSetGCC
    bash --rcfile "$SCRIPT_DIR/zzz.sh"
}

