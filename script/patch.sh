#!/bin/bash

THIS_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
source ${THIS_DIR}/env.sh

for patchfile in $PATCH_DIR/*.patch; do
    name=$(basename "$patchfile")
    dest="${name%-*}"
    mkdir -p $dest && cd $dest
    echo "cd $dest; patch -p1 --dry-run < $PATCH_DIR/$patchfile"
    # tar -xf "$tarball" -C $dest --strip-components=1
done

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
