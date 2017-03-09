#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qphix
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_dslash_scalar_avx_s4 ]; 
then 
  rm -rf ./build_dslash_scalar_avx_s4
fi

mkdir  ./build_dslash_scalar_avx_s4
cd ./build_dslash_scalar_avx_s4


${SRCDIR}/qphix/configure \
	--prefix=${INSTALLDIR}/dslash-avx-s4 \
	--with-qdp=${INSTALLDIR}/qdp++ \
	--enable-proc=AVX \
	--enable-soalen=4 \
	--enable-clover \
	--enable-cean \
	--enable-mm-malloc \
	--with-gtest=${SRCDIR}/gtest-1.7.0 \
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
