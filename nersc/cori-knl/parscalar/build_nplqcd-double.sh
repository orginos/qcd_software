#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh


pushd ${BUILDDIR}

if [ -d ./build_nplqcd-double ]; 
then 
  rm -rf ./build_nplqcd-double
fi

mkdir  ./build_nplqcd-double
cd ./build_nplqcd-double

CHROMA_DIR=${INSTALLDIR}/chroma-double

cmake -DCHROMA_PREFIX_PATH=${CHROMA_DIR} -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/nplqcd-double ${SRCDIR}/nplqcd

${MAKE}
${MAKE} install

popd
