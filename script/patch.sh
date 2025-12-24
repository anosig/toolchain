`#!/bin/bash

HERE=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
PRJ=$(cd $HERE/../ && pwd)

cd $PRJ/aux

rm -rf patch && mkdir -p patch
cp -R $PRJ/patches/* patch/;

patch -p1 --dry-run < patch/gmp-6.2.1.patch
patch -p1 --dry-run < patch/mpc-1.2.1.patch
patch -p1 --dry-run < patch/mpfr-4.1.0.patch

rm -rf patch
