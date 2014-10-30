#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qdp++
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++-double-scalar ]; 
then 
  rm -rf ./build_qdp++-double-scalar
fi

mkdir  ./build_qdp++-double-scalar
cd ./build_qdp++-double-scalar


${SRCDIR}/qdp++/configure \
	--prefix=${INSTALLDIR}/qdp++-double-scalar \
	--with-libxml2=${INSTALLDIR}/libxml2 \
        --enable-parallel-arch=scalar \
	--enable-sse2 --enable-db-lite \
	--enable-precision=double \
	--enable-largefile \
	--enable-parallel-io \
        --enable-dml-output-buffering \
	CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
