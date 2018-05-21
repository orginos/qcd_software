#!/bin/bash
source ./env.sh
pushd $INSTALLDIR
rm -rf chroma-double chroma libxml2  mdwf  qdp++  qdp++-double  qdpc  qio  qla  qmp  qopqdp
popd
