#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh

pushd ${BUILDDIR}

if [ -d ./build_qphix ]; 
then 
  rm -rf ./build_qphix
fi

mkdir  ./build_qphix
cd ./build_qphix

CXX=${PK_CXX} CXXFLAGS="${PK_CXXFLAGS}" \
cmake -Disa=${PK_QPHIX_ISA} \
      -Dhost_cxx=${PK_HOST_CXX} \
      -Dhost_cxxflags="${PK_HOST_CXXFLAGS}" \
      -Drecursive_jN=${PK_TARGET_JN} \
      -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/qphix_${PK_QPHIX_ISA} \
      -DQDPXX_DIR=${INSTALLDIR}/qdp++ \
   -DPYTHON_EXECUTABLE=${PK_PYTHON_EXE} \
      -DPYTHON_LIBRARY=${PK_PYTHON_LIB} \
      -DPYTHON_INCLUDE_DIR=${PK_PYTHON_INC} \
      -Dclover=TRUE \
      -Dcean=FALSE \
      -Dqdpalloc=FALSE \
      -Dqdpjit=FALSE  \
      -Dtesting=TRUE \
      -Dtm_clover=TRUE \
      -DCMAKE_EXE_LINKER_FLAGS="-lpthread" \
      ${SRCDIR}/qphix

make -j ${PK_TARGET_JN}
make install

popd
