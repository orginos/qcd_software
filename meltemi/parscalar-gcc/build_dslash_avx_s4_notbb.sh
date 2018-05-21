#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh

pushd ${SRCDIR}/qphix
autoreconf -f -i
popd

pushd ${BUILDDIR}

if [ -d ./build_dslash_avx_s4_notbb ]; 
then 
  rm -rf ./build_dslash_avx_s4_notbb
fi

mkdir  ./build_dslash_avx_s4_notbb
cd ./build_dslash_avx_s4_notbb


${SRCDIR}/qphix/configure \
    --prefix=${INSTALLDIR}/dslash-avx-s4_notbb \
    --with-qdp=${INSTALLDIR}/qdp++-notbb \
    --enable-proc=${PK_AVX_VERSION} \
    --enable-soalen=4 \
    --enable-clover \
    --disable-cean \
    --enable-qdpalloc \
    CXXFLAGS="${PK_CXXFLAGS}" \
    CFLAGS="${PK_CFLAGS}" \
    CXX="${PK_CXX}" \
    CC="${PK_CC}" \
    --host=x86_64-linux-gnu --build=none \
    ${OMPENABLE}
${MAKE} clean
${MAKE}
${MAKE} install

popd
