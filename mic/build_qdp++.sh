#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qdpxx
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++-parscalar-mic ]; 
then 
  rm -rf ./build_qdp++-parscalar-mic
fi

mkdir  ./build_qdp++-parscalar-mic
cd ./build_qdp++-parscalar-mic


${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++-parscalar \
	--enable-precision=single \
        --enable-parallel-arch=parscalar \
        --disable-filedb \
        --enable-largefile \
        --enable-parallel-io \
        --enable-alignment=64 \
	--with-qmp=${INSTALLDIR}/qmp \
	--with-libxml2=${INSTALLDIR}/libxml2\
	CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
