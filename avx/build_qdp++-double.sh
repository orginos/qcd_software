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

if [ -d ./build_qdpxx-parscalar-avx-double ]; 
then 
  rm -rf ./build_qdpxx-parscalar-avx-double
fi

mkdir  ./build_qdpxx-parscalar-avx-double
cd ./build_qdpxx-parscalar-avx-double


${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++-double \
        --enable-parallel-arch=parscalar \
	--enable-precision=double \
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
