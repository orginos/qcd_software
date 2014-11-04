#!/bin/bash
source ./env.sh
pushd $INSTALLDIR
rm -rf chroma  chroma-double  dslash-avx-s4  dslash-avx-s8  libxml2  qdp++  qdp++-double  qmp
popd
