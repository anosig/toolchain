#!/bin/bash

THIS_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
source ${THIS_DIR}/env.sh

opt_unlink=0
while [[ "$1" != "" ]]; do
    case "$1" in
        --unlink )
            opt_unlink=1
            shift
            ;;
        * )
            echo "Error: Invalid argument $1"
            exit 1
            ;;
    esac
done


# packages=("gmp" "mpc" "mpfr" "gettext" "isl")

# if [[ "$opt_unlink" == "1" ]]; then
#     for name in "${packages[@]}"; do
#         rm $SUBMOD_DIR/gcc/$name
#     done; echo "dist_symlink.sh: Removed symlinks"
# else
#     for name in "${packages[@]}"; do
#         ln -s $DIST_DIR/$name $SUBMOD_DIR/gcc/$name
#     done; echo "dist_symlink.sh: Placed symlinks"
# fi


if [[ "$opt_unlink" == "1" ]]; then
    cd $SUBMOD_DIR/gcc
    rm gmp mpc mpfr gettext isl
    echo "dist_symlink.sh: Removed symlinks"
else
    cd $SUBMOD_DIR/gcc
    ln -s ${DIST_DIR}/gmp .
    ln -s ${DIST_DIR}/mpc .
    ln -s ${DIST_DIR}/mpfr .
    ln -s ${DIST_DIR}/gettext .
    ln -s ${DIST_DIR}/isl .
    echo "dist_symlink.sh: Placed symlinks"
fi

