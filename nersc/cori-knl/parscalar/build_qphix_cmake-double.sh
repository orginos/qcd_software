#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh

pushd ${BUILDDIR}

if [ -d ./build_qphix-double ]; 
then 
  rm -rf ./build_qphix-double
fi

mkdir  ./build_qphix-double
cd ./build_qphix-double

CC=${PK_CC} CFLAGS=${PK_CFLAGS} CXX=${PK_CXX} CXXFLAGS="${PK_CXXFLAGS}" \
cmake -Disa=${PK_QPHIX_ISA} \
      -G"Eclipse CDT4 - Unix Makefiles" \
      -Dhost_cxx=${PK_HOST_CXX} \
      -Dhost_cxxflags="${PK_HOST_CXXFLAGS}" \
      -Drecursive_jN=${PK_TARGET_JN} \
      -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/qphix_${PK_QPHIX_ISA}-double \
      -DQDPXX_DIR=${INSTALLDIR}/qdp++-double \
      -Dclover=TRUE \
      -Dtm_clover=TRUE \
      -Dcean=FALSE \
      -Dqdpalloc=FALSE \
      -Dqdpjit=FALSE  \
      -Dtesting=TRUE \
      -Dtm_clover=TRUE \
      ${SRCDIR}/qphix

make -j ${PK_TARGET_JN}
make install

popd
