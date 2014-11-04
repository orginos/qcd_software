#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qphix
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_dslash_avx_s8 ]; 
then 
  rm -rf ./build_dslash_avx_s8
fi

mkdir  ./build_dslash_avx_s8
cd ./build_dslash_avx_s8


${SRCDIR}/qphix/configure \
	--prefix=${INSTALLDIR}/dslash-avx-s8 \
	--with-qdp=${INSTALLDIR}/qdp++-double \
	--enable-proc=AVX \
	--enable-soalen=8 \
	--enable-clover \
	--enable-mm-malloc \
	--enable-cean \
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
