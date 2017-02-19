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

CHROMA_DIR=${INSTALLDIR}/chroma-scalar

cmake -DCMAKE_C_COMPILER="${PK_CC}" -DCMAKE_CXX_COMPILER="${PK_CXX}" -DCHROMA_PREFIX_PATH=${CHROMA_DIR} -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/wm_chroma-scalar ${SRCDIR}/wm_chroma

${MAKE}
${MAKE} install

popd
