#!/bin/bash
source ./env.sh
pushd $INSTALLDIR
rm -rf chroma-double-scalar  chroma-scalar  libxml2  qdp++-double-scalar  qdp++-scalar
popd
