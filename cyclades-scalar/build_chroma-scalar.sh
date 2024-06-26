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

if [ -d ./build_chroma-scalar ]; 
then 
  rm -rf ./build_chroma-scalar
fi

mkdir  ./build_chroma-scalar
cd ./build_chroma-scalar


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma-scalar \
    --with-qdp=${INSTALLDIR}/qdp++-scalar \
    --enable-cpp-wilson-dslash --enable-sse2 --enable-sse3 ${OMPENABLE} \
    --enable-sse-scalarsite-bicgstab-kernels --host=x86_64-linux-gnu --build=none \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    LIBS=" -llapack -lblas " \
    --enable-lapack=lapack \
    --host=x86_64-linux-gnu --build=none
${MAKE}
${MAKE} install

popd
