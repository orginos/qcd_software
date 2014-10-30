#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/cpp_wilson_dslash
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_dslash_mic_s16 ]; 
then 
  rm -rf ./build_dslash_mic_s16
fi

mkdir  ./build_dslash_mic_s16
cd ./build_dslash_mic_s16


${SRCDIR}/cpp_wilson_dslash/configure \
	--prefix=${INSTALLDIR}/dslash-mic-s16 \
	--with-qdp=${INSTALLDIR}/qdp++ \
	--enable-proc=MIC \
	--enable-soalen=16 \
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
