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

CXX=${PK_CXX} CXXFLAGS="${PK_CXXFLAGS}" \
cmake -Disa=${PK_QPHIX_ISA} \
      -Dhost_cxx=${PK_HOST_CXX} \
      -Dhost_cxxflags="${PK_HOST_CXXFLAGS}" \
      -Drecursive_jN=${PK_TARGET_JN} \
      -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/qphix-double_${PK_QPHIX_ISA} \
      -DQDPXX_DIR=${INSTALLDIR}/qdp++ \
   -DPYTHON_EXECUTABLE=${PK_PYTHON_EXE} \
      -DPYTHON_LIBRARY=${PK_PYTHON_LIB} \
      -DPYTHON_INCLUDE_DIR=${PK_PYTHON_INC} \
      -Dclover=TRUE \
      -Dcean=FALSE \
      -Dqdpalloc=FALSE \
      -Dqdpjit=FALSE  \
      -Dtm_clover=TRUE \
      -Dtesting=FALSE \
      -DCMAKE_EXE_LINKER_FLAGS="-lpthread" \
      ${SRCDIR}/qphix

make -j ${PK_TARGET_JN}
make install

popd
