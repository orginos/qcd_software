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

if [ -d ./build_qdp++-double ]; 
then 
  rm -rf ./build_qdp++-double
fi

mkdir  ./build_qdp++-double
cd ./build_qdp++-double


#use the native libxml2 on MAC OS X
	#--with-libxml2=${INSTALLDIR}/libxml2 \ 

${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++/mpi-double \
	--enable-parallel-arch=parscalar \
        --enable-precision=single \
	--enable-filedb \
	--disable-generics \
	--with-qmp=${INSTALLDIR}/qmp-mpi \
	--enable-alignment=64 \
	--enable-precision=double \
        --enable-largefile \
	CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
#	LIBS="-lmpi " \
#	LDFLAGS="-L/usr/local/lib/ -lmpi"
