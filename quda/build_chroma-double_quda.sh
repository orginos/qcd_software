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

if [ -d ./build_chroma-double ]; 
then 
  rm -rf ./build_chroma-double
fi

mkdir  ./build_chroma-double
cd ./build_chroma-double


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma-double_quda \
	--with-qdp=${INSTALLDIR}/qdp++-double \
        --enable-cpp-wilson-dslash --enable-sse2 --enable-sse3 ${OMPENABLE} \
        --with-qmp=${INSTALLDIR}/qmp \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" \
        --enable-sse-scalarsite-bicgstab-kernels --host=x86_64-linux-gnu --build=none \
        --with-quda=${INSTALLDIR}/quda \
        --with-cuda=${PK_CUDA_HOME}
${MAKE}
${MAKE} install

popd
