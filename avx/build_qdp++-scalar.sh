#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qdpxx
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qdpxx-scalar-avx ]; 
then 
  rm -rf ./build_qdpxx-scalar-avx
fi

mkdir  ./build_qdpxx-scalar-avx
cd ./build_qdpxx-scalar-avx


${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++-scalar \
        --enable-parallel-arch=scalar \
	--enable-precision=double \
        --disable-filedb \
        --enable-largefile \
        --enable-parallel-io \
        --enable-alignment=64 \
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
