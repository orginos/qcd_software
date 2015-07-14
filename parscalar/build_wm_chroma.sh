#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh


pushd ${BUILDDIR}

if [ -d ./build_wm_chroma ]; 
then 
  rm -rf ./build_wm_chroma
fi

mkdir  ./build_wm_chroma
cd ./build_wm_chroma
cp -p -r ${SRCDIR}/wm_chroma/* .

cat > Makefile<<EOF
CHROMA_DIR = ${INSTALLDIR}/chroma
ARPREC_DIR = ${INSTALLDIR}/arprec
QD_DIR = ${INSTALLDIR}/qd
ITPP_DIR = ${INSTALLDIR}/itpp
include Make.inc
EOF

${MAKE}
INSTALL_DIR=/usr/local/scidac/wm_chroma/scalar 
if [ -d $INSTALL_DIR ]; 
then 
  rm -rf $INSTALL_DIR
fi
mkdir -p $INSTALL_DIR
cp wm_chroma $INSTALL_DIR

popd
