#!/bin/bash
source ./env.sh
pushd $INSTALLDIR
rm -rf chroma-double_quda  chroma_quda  libxml2  qdp++  qdp++-double  qmp  quda
popd
