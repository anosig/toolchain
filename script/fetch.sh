#!/bin/bash

THIS_DIR=$(cd $(dirname ${BASH_SOURCE[0]}) && pwd)
source ${THIS_DIR}/env.sh

opt_clean=0
while [[ "$1" != "" ]]; do
    case "$1" in
        --clean )
            opt_clean=1
            shift
            ;;
        * )
            echo "Error: Invalid argument $1"
            exit 1
            ;;
    esac
done

cd ${DIST_DIR}

if [[ "$opt_clean" == "1" ]]; then
    rm -rf *.tar.* */ 
    rm -rf */ 
fi

while read -r name url; do
    file="${url##*/}"
    if [[ ! -f "$file" ]]; then
        echo "Downloading $file"
        curl -L -O "$url"
    else
        echo "Using cached $file"
    fi
done < manifest.txt

for tarball in ./*.tar.*; do
    name=$(basename "$tarball")
    echo "Extracting $name"
    dest="${name%-*}"
    mkdir -p $dest
    tar -xf "$tarball" -C $dest --strip-components=1
done

if [[ "$opt_clean" == "1" ]]; then
    sha256sum *.tar.* > checksum.sha256
else
    sha256sum -c checksum.sha256
fi
