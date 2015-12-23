#!/bin/bash
source ./env.sh
pushd $BUILDDIR
rm -rf build_chroma  build_chroma-double  build_libxml2  build_mdwf  build_qdp++  build_qdp++-double  build_qdpc  build_qio  build_qla  build_qmp  build_qopqdp
popd
