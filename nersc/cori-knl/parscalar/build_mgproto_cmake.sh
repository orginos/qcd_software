#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh

pushd ${BUILDDIR}

if [ -d ./build_mg_proto ]; 
then 
  rm -rf ./build_mg_proto
fi


mkdir  ./build_mg_proto
cd ./build_mg_proto 

CXX=${PK_CXX} CC=${PK_CC} CXXFLAGS="${PK_CXXFLAGS} -g" cmake \
    -G"Eclipse CDT4 - Unix Makefiles" \
    -DMG_USE_KOKKOS=FALSE \
    -DMG_USE_QPHIX=TRUE \
    -DQPHIX_DIR=${INSTALLDIR}/qphix_${PK_QPHIX_ISA} \
    -DMG_QPHIX_COMPRESS12=TRUE \
    -DMG_QPHIX_SOALEN=8 \
    -DMG_USE_AVX512=TRUE \
    -DEigen3_DIR=${SRCDIR}/eigen-3.3.4 \
    -DKOKKOS_ENABLE_CUDA=FALSE \
    -DCMAKE_ECLIPSE_MAKE_ARGUMENTS=-j8 \
    -DCMAKE_ECLIPSE_VERSION=4.5.0 \
    -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/mg_proto \
    -DKOKKOS_HOST_ARCH="${PK_KOKKOS_HOST_ARCH}" \
    -DQDPXX_DIR=${INSTALLDIR}/qdp++ \
    -DMG_DEFAULT_LOGLEVEL=DEBUG \
    -DMG_KOKKOS_USE_NEIGHBOR_TABLE=FALSE \
     ${SRCDIR}/mg_proto

${MAKE} VERBOSE=1
${MAKE} install

popd
