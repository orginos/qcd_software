#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh


pushd ${BUILDDIR}

if [ -d ./build_OpenBLAS ]; 
then 
  rm -rf ./build_OpenBLAS
fi

mkdir  ./build_OpenBLAS
cd ./build_OpenBLAS


cmake -DCMAKE_C_COMPILER=$PK_CC -DCMAKE_CXX_COMPILER=$PK_CXX -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/OpenBLAS $SRCDIR/OpenBLAS

${MAKE}
${MAKE} test

popd
