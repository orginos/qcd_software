#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh


pushd ${BUILDDIR}

if [ -d ./build_dslash_avx ]; 
then 
  rm -rf ./build_dslash_avx
fi

mkdir  ./build_dslash_avx
cd ./build_dslash_avx


CXX=${PK_CXX} CXXFLAGS="${PK_CXXFLAGS}" \
cmake -Disa=${PK_QPHIX_ISA} \
      -Dhost_cxx=${PK_HOST_CXX} \
      -Dhost_cxxflags="${PK_HOST_CXXFLAGS}" \
      -Drecursive_jN=${PK_TARGET_JN} \
      -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/qphix_${PK_QPHIX_ISA} \
      -DQDPXX_DIR=${INSTALLDIR}/qdp++ \
      -Dclover=TRUE \
      -Dcean=FALSE \
      -Dqdpalloc=TRUE \
      -Dqdpjit=FALSE \
      -DPYTHON_INCLUDE_DIR=/usr/local/intel64/knl/intel/intelpython3/include \
      -DPYTHON_LIBRARY=/usr/local/intel64/knl/intel/intelpython3/lib \
      -DCMAKE_EXE_LINKER_FLAGS="-L${TBBLIBDIR} -ltbb -ltbbmalloc" \
      ${SRCDIR}/qphix

make -j ${PK_TARGET_JN}
make install


popd
