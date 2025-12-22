#!/bin/bash

set -e

if [ -z "$TARGET" ]; then
    echo "Invalid usage: TARGET not set"
    exit 1
elif [ -z "$PREFIX" ]; then
    echo "Invalid usage: PREFIX not set"
    exit 1
fi

THIS_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
source ${THIS_DIR}/env.sh

BUILD_DIR=${REPO_ROOT}/build/${TARGET}
mkdir -p ${BUILD_DIR}

getRelative()
{
    base=$1; stem=$2;
    echo $(realpath --relative-to="$base" "$stem");
}

makePretty()
{
    dir=$1;
    dir=$(cd $dir && pwd);
    echo $dir;
}

touchAndMakePretty()
{
    dir=$1; mkdir -p $dir;
    dir=$(cd $dir && pwd);
    echo $dir;
}

# REPO_PARENT=$(makePretty "$REPO_ROOT/../")
# BUILD_DIR=$(touchAndMakePretty "$REPO_PARENT/anos-build/$TARGET")
# mkdir -p "$BUILD_DIR"

# while [[ "$1" != "" ]]; do
#     case "$1" in
#         --clean )
#             rm -rf $BUILD_DIR/*
#             $SCRIPT_DIR/dist_fetch.sh --clean
#             shift
#             ;;
#         * )
#             echo "Error: Invalid argument $1"
#             exit 1
#             ;;
#     esac
# done

getBuildDest()
{
    dir=$(getRelative "$REPO_ROOT" "$1")
    echo $(touchAndMakePretty "$BUILD_DIR/$dir")
}

mkdist()
{
    name=$1; shift;

    source=$DIST_DIR/$name; cd $(getBuildDest "$source");
    $source/configure --prefix="$PREFIX" $@

    make -j$(nproc);  make install;
}

mksubmod()
{
    name=$1; shift;

    source=$SUBMOD_DIR/$name; cd $(getBuildDest "$source");
    $source/configure --prefix="$PREFIX" $@

    make -j$(nproc);
    make install;
}


mksubmod_gcc()
{
    source=$SUBMOD_DIR/gcc; cd $(getBuildDest "$source");
    $source/configure \
        --prefix="$PREFIX" --target=$TARGET \
        --disable-nls --enable-languages=c,c++ \
        --without-headers --disable-hosted-libstdcxx  \
        --disable-multilib

    make -j$(nproc) all-gcc                 && make install-gcc;
    make -j$(nproc) all-target-libgcc       && make install-target-libgcc;
    make -j$(nproc) all-target-libstdc++-v3 && make install-target-libstdc++-v3;
}


# mksubmod_limine()
# {
#     cd $SUBMOD_DIR/limine

#     if [[ ! -f "configure" ]]; then
#         ./bootstrap
#     fi

#     ./configure \
#         TOOLCHAIN_FOR_TARGET=x86_64-elf-anos- \
#         --prefix=$HOME/devel/anos_opt/x86_64-elf \
#         --enable-bios-cd=yes --enable-bios-pxe=yes --enable-bios=yes \
#         --enable-uefi-x86-64=yes --enable-uefi-cd

#     make -j$(nproc)
#     make install

#     # mkdir -p $AUX_BUILD/include/limine
#     # cp ./limine-protocol/{include/*,LICENSE,*.md} $AUX_BUILD/include/limine/
# }



mkdist autoconf --target=$TARGET
mkdist automake --target=$TARGET

# mkdist gettext --target=$TARGET
# mkdist gmp
# mkdist isl --target=$TARGET
# mkdist mpc --target=$TARGET
# mkdist mpfr --target=$TARGET
mksubmod binutils --target=$TARGET --with-sysroot --disable-nls --disable-werror
mksubmod_gcc


# mksubmod_gcc
# build_limine

# mksubmod limine TOOLCHAIN_FOR_TARGET=$TARGET- \
#     --enable-bios-cd=yes --enable-bios-pxe=yes --enable-bios=yes \
#     --enable-uefi-x86-64=yes --enable-uefi-cd

# find $TOOLCHAIN_PREFIX/lib -name 'libgcc.a'
