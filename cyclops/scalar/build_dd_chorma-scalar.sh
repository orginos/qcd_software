#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/dd_chroma
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_dd_chroma-scalar ]; 
then 
  rm -rf ./build_dd_chroma-scalar
fi

mkdir  ./build_dd_chroma-scalar
cd ./build_dd_chroma-scalar


${SRCDIR}/dd_chroma/configure --prefix=${INSTALLDIR}/dd_chroma-scalar \
	--with-qdp=${INSTALLDIR}/qdp++-scalar \
        --enable-cpp-wilson-dslash --enable-sse2 --enable-sse3 ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="${PK_CXXFLAGS}" CFLAGS="${PK_CFLAGS}" \
        --host=x86_64-linux-gnu --build=none
${MAKE}
${MAKE} install

popd
