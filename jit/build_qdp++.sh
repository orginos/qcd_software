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

if [ -d ./build_qdp++ ]; 
then 
  rm -rf ./build_qdp++
fi

mkdir  ./build_qdp++
cd ./build_qdp++


${SRCDIR}/qdp-jit/configure \
	--prefix=${INSTALLDIR}/qdp++ \
	--with-libxml2=${INSTALLDIR}/libxml2 \
	--with-qmp=${INSTALLDIR}/qmp \
        --enable-parallel-arch=parscalar \
	--enable-precision=single \
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
