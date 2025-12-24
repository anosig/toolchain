#!/bin/bash
set -e

HERE=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
PRJ=$(cd $HERE/../ && pwd)
OUT="${PRJ}/build/${TARGET}" && mkdir -p $OUT

opt_target="x86_64-elf"
while [[ "$1" != "" ]]; do
    case "$1" in
        --target )
            opt_target=$2
            shift
            shift
            ;;
        * )
            echo "Error: Invalid argument $1"
            exit 1
            ;;
    esac
done


mkdist()
{
    name=$1; shift;
    source=$DIST_DIR/$name; mkdir -p $OUT/$name; cd $OUT/$name;
    $source/configure --prefix="$PREFIX" $@
    make -j$(nproc);  make install;
}

mkdist_gcc()
{   # This may require a workaround. First compile binutils as usual,
    # then add the binaries to the PATH, and start to compile gcc.
    # When compiling libgcc with -mcmodel=kernel, it will fail.
    # Then patch the Makefile to disable PIC, repeat and continue:
    name=gcc;

    source=$DIST_DIR/$name; mkdir -p $OUT/$name;
    cd $source && $source/contrib/download_prerequisites;
    cd $OUT/$name;
    $source/configure \
        --prefix="$PREFIX" --target=$TARGET \
        --disable-nls --enable-languages=c,c++ \
        --without-headers --disable-hosted-libstdcxx  \
        --disable-multilib

    # make -j$(nproc) all-gcc all-target-libgcc all-target-libstdc++-v3;
    # make install-gcc install-target-libgcc install-target-libstdc++-v3;

    make -j$(nproc) all-gcc;
    make install-gcc;

    make -j$(nproc) all-target-libgcc CFLAGS_FOR_TARGET='-g -O2 -mcmodel=kernel -mno-red-zone' || true
    # will fail with: cc1: error: code model kernel does not support PIC mode
    sed -i 's/PICFLAG/DISABLED_PICFLAG/g' $TARGET/libgcc/Makefile
    make -j$(nproc) all-target-libgcc CFLAGS_FOR_TARGET='-g -O2 -mcmodel=kernel -mno-red-zone'
    make install-target-libgcc;

    make -j$(nproc) all-target-libstdc++-v3
    make install-target-libstdc++-v3;
};


mkdist autoconf --target=$TARGET
mkdist automake --target=$TARGET
mkdist binutils --target=$TARGET --with-sysroot --disable-nls --disable-werror

export PATH="$PREFIX/bin:$PATH"
mkdist_gcc









# build_package()
# {
#     PKG_NAME=$1
#     TGT_FLAG=--target=$TARGET
#     if [[ "$2" == "--no-target" ]]; then
#         TGT_FLAG=""
#     fi
#     mkdir -p $BUILD/$PKG_NAME && cd $BUILD/$PKG_NAME
#     $BUILD/$PKG_NAME/configure $TGT_FLAG --prefix="$PREFIX"
#     make -j$(nproc)
#     make install
# }

# build_binutils()
# {
#     mkdir -p $BUILD/binutils && cd $BUILD/binutils
#     ${BUILD_ROOT}/inutils-gdb/configure --prefix=$PREFIX --target=$TARGET --with-sysroot --disable-nls --disable-werror
#     make -j$(nproc)
#     make install
# }

# build_gcc()
# {
#     mkdir -p $BUILD/gcc; cd $BUILD/gcc;
#     which -- $TARGET-as; ATH;

#     ${BUILD_ROOT}/gcc/configure --prefix=$PREFIX --target=$TARGET --disable-nls --enable-languages=c,c++ --withBUILD_ROOT-headers --disable-hosted-libstdcxx
#     make -j$(nproj) all-gcc && make install-gcc
#     make -j$(nproj) all-target-libgcc && all-target-libstdc++-v3
#     make -j$(nproj) install-target-libgcc && install-target-libstdc++-v3

#     # make all-gcc all-target-libgcc all-target-libstdc++-v3
#     # make install-gcc install-target-libgcc install-target-libstdc++-v3
#     # find $TOOLCHAIN_PREFIX/lib -name 'libgcc.a'
# }

# build_package autoconf
# build_package automake
# # build_package gcc/gmp-6.2.1 --no-target
# # build_package gcc/mpc-1.2.1
# # build_package gcc/mpfr-4.1.0
# build_binutils
# # build_gcc

