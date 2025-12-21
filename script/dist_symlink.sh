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

# create_symlinks()
# {
#     cd $DIST_DIR
#     for dir in */; do
#         ln -s "$(pwd)/$dir" "$SUBMOD_DIR/gcc/";
#     done
# }

# remove_symlinks()
# {
#     cd $SUBMOD_DIR/gcc
#     for dir in */; do
#         ln -s "$(pwd)/$dir" "$SUBMOD_DIR/gcc/"
#     done
# }

