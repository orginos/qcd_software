#!/bin/bash
source ./env.sh
pushd $BUILDDIR
rm -rf build_chroma  build_chroma-double  build_libxml2  build_qdp++  build_qdp++-double  build_qmp  build_quda
popd
