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

if [ -d ./build_dslash_mic_s4 ]; 
then 
  rm -rf ./build_dslash_mic_s4
fi

mkdir  ./build_dslash_mic_s4
cd ./build_dslash_mic_s4


${SRCDIR}/cpp_wilson_dslash/configure \
	--prefix=${INSTALLDIR}/dslash-mic-s4 \
	--with-qdp=${INSTALLDIR}/qdp++-parscalar-double \
	--enable-proc=MIC \
	--enable-soalen=4 \
	--enable-veclen=16 \
	--enable-clover \
	--enable-cean \
	--enable-mm-malloc \
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
