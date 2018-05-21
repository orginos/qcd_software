#!/bin/bash
source ./env.sh
pushd $BUILDDIR
rm -rf build_chroma  build_chroma-double  build_dslash_avx_s4  build_dslash_avx_s8  build_libxml2  build_qdpxx-parscalar-avx  build_qdpxx-parscalar-avx-double  build_qmp
popd
