#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh


pushd ${BUILDDIR}

if [ -d ./build_wm_chroma-scalar ]; 
then 
  rm -rf ./build_wm_chroma-scalar
fi

mkdir  ./build_wm_chroma
cd ./build_wm_chroma

CHROMA_DIR=/usr/local/scidac/chroma/scalar

cmake -DCHROMA_PREFIX_DIR=${CHROMA_DIR} -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/wm_chroma/scalar ${SRCDIR}/wm_chroma

${MAKE}
${MAKE} install

popd
