#!/bin/bash
#
#################
# BUILD QDP++
#################
source env.sh

pushd ${SRCDIR}/qdpxx
autoreconf -f -i
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++_dp ]; 
then 
  rm -rf ./build_qdp++_dp
fi

mkdir  ./build_qdp++_dp
cd ./build_qdp++_dp


#use the native libxml2 on MAC OS X
	#--with-libxml2=${INSTALLDIR}/libxml2 \ 

${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++/mpi-dp \
	--enable-sse2 --enable-sse3 \
        --enable-parallel-arch=parscalar \
	--enable-db-lite \
	--enable-precision=double \
	--enable-largefile \
	--enable-parallel-io \
        --enable-dml-output-buffering \
	--with-qmp=${INSTALLDIR}/qmp-mpi 
	CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	LIBS="-lmpi " \
	LDFLAGS="-L/usr/local/lib/ -lmpi"
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
