#!/bin/bash
set -e

THIS_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
source ${THIS_DIR}/env.sh

cd $PATCH_DIR
# for f in ./*; do
#     name=$(basename "$f")
#     name=${name%-*}
#     if [[ -d "$dest" ]]; then
#         cd "$DIST_DIR/$name";
#         patch -p1 < "$PATCH_DIR/$f"
#     fi
# done


# export ANOS_FLAGS=("gmp" "mpc" "mpfr" "gettext" "isl")
# export ANOS_FLAG_VALUES=()
# parse_options()
# {
#     # Add elements one by one
#     while [[ "$1" != "" ]]; do
#         # for key in "${ANOS_FLAGS[@]}"; do
#         #     if [[ "$1" == "$key" ]]; then
#         #         ANOS_FLAG_VALUES[name]="Satoshi"
                
#         #     fi
#         # done;
#         shift
#     done
# }


export PREFIX="$HOME/opt/cross/x86_64-linux-gnu"
export PATH="$PREFIX/bin:$PATH"

# cd $DIST_DIR/binutils
# patch -p1 < ${PATCH_DIR}/binutils-2.45.patch
# cd ./ld && $PREFIX/bin/automake

cd $HOME/devel/gcc
# git apply -p1 "${PATCH_DIR}/gcc-15.2.0.patch"
git apply -p1 "${PATCH_DIR}/gcc-15.2.0_no-red-zone.patch"
# cd ./libstdc++-v3 && $PREFIX/bin/autoconf


# write_patch()
# {
#     name=$1; cd $name
#     patch -p1 --dry-run < $PATCH_DIR/name-*
# }

# cd $THIS_DIR/patch
# patch -p1 --dry-run < patch/gcc-15.2.0.patch
# patch -p1 --dry-run < patch/gmp-6.2.1.patch
# patch -p1 --dry-run < patch/mpc-1.2.1.patch
# patch -p1 --dry-run < patch/mpfr-4.1.0.patch

# export PREFIX="$HOME/opt/cross/x86_64-anos"
# export PATH="$PREFIX/bin:$OG_PATH"

# cd $DIST_DIR/binutils/ld;      $PREFIX/bin/automake;
# cd $DIST_DIR/gcc/libstdc++-v3; $PREFIX/bin/autoconf;
