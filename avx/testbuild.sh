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

if [ -d ./build_qphix_avx_s8 ]; 
then 
  rm -rf ./build_qphix_avx_s8
fi

mkdir  ./build_qphix_avx_s8
cd ./build_qphix_avx_s8


${SRCDIR}/qphix/configure \
	--prefix=${INSTALLDIR}/qphix-s8 \
	--with-qdp=${INSTALLDIR}/qdp++ \
	--enable-proc=AVX \
	--enable-soalen=8 \
	--enable-clover \
	CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

#       --with-qmp=${INSTALLDIR}/qmp 
${MAKE} clean
${MAKE}
${MAKE} install

popd
