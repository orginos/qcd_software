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

if [ -d ./build_chroma-double-scalar ]; 
then 
  rm -rf ./build_chroma-double-scalar
fi

mkdir  ./build_chroma-double-scalar
cd ./build_chroma-double-scalar


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma-double-scalar \
	--with-qdp=${INSTALLDIR}/qdp++-double-scalar \
        --with-gmp=/shared/gcc-5.3.0/lib64 \
        --enable-cpp-wilson-dslash --enable-sse2 --enable-sse3 ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" \
        --enable-sse-scalarsite-bicgstab-kernels --host=x86_64-linux-gnu --build=none
${MAKE}
${MAKE} install

popd
