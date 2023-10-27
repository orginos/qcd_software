#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qdpxx
autoreconf -f -i
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++-double-scalar ]; 
then 
  rm -rf ./build_qdp++-double-scalar
fi

mkdir  ./build_qdp++-double-scalar
cd ./build_qdp++-double-scalar


#use the native libxml2 on MAC OS X
	#--with-libxml2=${INSTALLDIR}/libxml2 \ 

${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++/scalar-dp \
	--enable-sse2 --enable-sse3 \
        --enable-parallel-arch=scalar \
	--enable-db-lite \
	--enable-precision=double \
	--enable-largefile \
	--enable-parallel-io \
        --enable-dml-output-buffering \
	CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
