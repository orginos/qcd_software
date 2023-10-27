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

if [ -d ./build_qdp++-scalar_3d ]; 
then 
  rm -rf ./build_qdp++-scalar_3d
fi

mkdir  ./build_qdp++-scalar_3d
cd ./build_qdp++-scalar_3d


#use the native libxml2 on MAC OS X
	#--with-libxml2=${INSTALLDIR}/libxml2 \ 

${SRCDIR}/qdpxx/configure \
        --enable-Nd=3 \
	--prefix=${INSTALLDIR}/qdp++/scalar_3d \
	--enable-sse2 --enable-sse3 \
        --enable-parallel-arch=scalar \
	--enable-db-lite \
	--enable-precision=single \
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
