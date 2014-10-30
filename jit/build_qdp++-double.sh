#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qdp-jit
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++-double ]; 
then 
  rm -rf ./build_qdp++-double
fi

mkdir  ./build_qdp++-double
cd ./build_qdp++-double


${SRCDIR}/qdp-jit/configure \
	--prefix=${INSTALLDIR}/qdp++-double \
	--with-libxml2=${INSTALLDIR}/libxml2 \
	--with-qmp=${INSTALLDIR}/qmp \
        --enable-parallel-arch=parscalar \
	--enable-precision=double \
	--enable-largefile \
	--enable-parallel-io \
        --enable-dml-output-buffering \
        --disable-generics \
        --disable-filedb \
        --with-cuda=${CUDA_INSTALL_PATH} \
        CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
