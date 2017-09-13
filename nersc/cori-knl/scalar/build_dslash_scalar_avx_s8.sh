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

if [ -d ./build_dslash_scalar_avx_s8 ]; 
then 
  rm -rf ./build_dslash_scalar_avx_s8
fi

mkdir  ./build_dslash_scalar_avx_s8
cd ./build_dslash_scalar_avx_s8


${SRCDIR}/qphix/configure \
	--prefix=${INSTALLDIR}/dslash-avx-s8 \
	--with-qdp=${INSTALLDIR}/qdp++-scalar \
	--enable-proc=AVX \
	--enable-soalen=4 \
	--enable-clover \
	--enable-cean \
	--enable-mm-malloc \
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
