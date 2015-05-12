#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
#autoreconf -f -i 
automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma-scalar ]; 
then 
  rm -rf ./build_chroma-scalar
fi

mkdir  ./build_chroma-scalar
cd ./build_chroma-scalar


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma/scalar \
	--with-qdp=${INSTALLDIR}/qdp++/scalar \
        --enable-cpp-wilson-dslash --enable-sse2 --enable-sse3 ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS=""   --enable-lapack=lapack \
        LIBS=" -llapack -lblas -framework Accelerate"\
        --enable-sse-scalarsite-bicgstab-kernels --host=x86_64-linux-gnu --build=none

${MAKE}
${MAKE} install

popd
