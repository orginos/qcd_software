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

if [ -d ./build_dslash_mic_s8_scalar ]; 
then 
  rm -rf ./build_dslash_mic_s8_scalar
fi

mkdir  ./build_dslash_mic_s8_scalar
cd ./build_dslash_mic_s8_scalar


${SRCDIR}/qphix/configure \
	--prefix=${INSTALLDIR}/dslash-mic-s8 \
	--with-qdp=${INSTALLDIR}/qdp++-scalar \
	--enable-proc=MIC \
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
