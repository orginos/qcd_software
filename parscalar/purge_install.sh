#!/bin/bash
source ./env.sh
pushd $INSTALLDIR
rm -rf chroma  chroma-double  libxml2  qdp++  qdp++-double  qmp
popd
