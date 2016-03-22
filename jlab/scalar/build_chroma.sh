#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma ]; 
then 
  rm -rf ./build_chroma
fi

mkdir  ./build_chroma
cd ./build_chroma


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma \
	--with-qdp=${INSTALLDIR}/qdp++ \
        --enable-cpp-wilson-dslash --enable-sse2 --enable-sse3 ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" \
        --with-lapack=lapack \
        LIBS=" -llapack -lblas" \
        --host=x86_64-linux-gnu --build=none

${MAKE}
${MAKE} install

popd
