#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma-dd
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma-dd-scalar ]; 
then 
  rm -rf ./build_chroma-dd-scalar
fi

mkdir  ./build_chroma-dd-scalar
cd ./build_chroma-dd-scalar


${SRCDIR}/chroma-dd/configure --prefix=${INSTALLDIR}/chroma-dd-scalar \
	--with-qdp=${INSTALLDIR}/qdp++-scalar \
        --enable-cpp-wilson-dslash --enable-sse2 --enable-sse3 ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="${PK_CXXFLAGS}" CFLAGS="${PK_CFLAGS}" \
        --host=x86_64-linux-gnu --build=none
${MAKE}
${MAKE} install

popd
