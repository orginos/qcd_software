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

CHROMA_DIR=${INSTALLDIR}/chroma

cmake -DCMAKE_C_COMPILER=/net/lattice-fs/data/software/opt/gcc-4.9.0/bin/gcc -DCMAKE_CXX_COMPILER=/net/lattice-fs/data/software/opt/gcc-4.9.0/bin/g++ -DCHROMA_PREFIX_PATH=${CHROMA_DIR} -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/wm_chroma ${SRCDIR}/wm_chroma

${MAKE}
${MAKE} install

popd
