#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh


pushd ${BUILDDIR}

if [ -d ./build_nplqcd ]; 
then 
  rm -rf ./build_nplqcd
fi

mkdir  ./build_nplqcd
cd ./build_nplqcd

CHROMA_DIR=${INSTALLDIR}/chroma

cmake -DCHROMA_PREFIX_PATH=${CHROMA_DIR} -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/nplqcd -DCMAKE_CXX_COMPILER=${PK_CXX} ${SRCDIR}/nplqcd

${MAKE}
${MAKE} install

popd
