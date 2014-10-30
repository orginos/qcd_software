#!/bin/bash
source ./env.sh
pushd $BUILDDIR
rm -rf build_chroma-double-scalar  build_chroma-scalar  build_libxml2  build_qdp++-double-scalar  build_qdp++-scalar
popd
