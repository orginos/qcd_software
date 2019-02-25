#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh

pushd ${SRCDIR}/qdpxx
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qdpxx-parscalar-avx-double_3d ]; 
then 
  rm -rf ./build_qdpxx-parscalar-avx-double_3d
fi

mkdir  ./build_qdpxx-parscalar-avx-double_3d
cd ./build_qdpxx-parscalar-avx-double_3d


${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++-double_3d \
        --enable-Nd=3 \
        --enable-parallel-arch=parscalar \
	--enable-precision=double \
        --disable-filedb \
	--disable-generics \
        --enable-largefile \
        --enable-parallel-io \
        --enable-alignment=64 \
	--with-qmp=${INSTALLDIR}/qmp \
	--with-libxml2=${INSTALLDIR}/libxml2\
	CXXFLAGS="${PK_CXXFLAGS} -fpermissive " \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}
${MAKE}
${MAKE} install

popd