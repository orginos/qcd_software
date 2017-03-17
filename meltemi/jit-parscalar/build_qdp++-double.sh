#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh

pushd ${SRCDIR}/qdp-jit-llvm-x86
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++-double ]; 
then 
  rm -rf ./build_qdp++-double
fi

mkdir  ./build_qdp++-double
cd ./build_qdp++-double


${SRCDIR}/qdp-jit-llvm-x86/configure \
	--prefix=${INSTALLDIR}/qdp++-double \
	--with-libxml2=${INSTALLDIR}/libxml2 \
	--with-qmp=${INSTALLDIR}/qmp \
        --enable-parallel-arch=parscalar \
	--enable-precision=double \
	--enable-largefile \
	--enable-parallel-io \
        --enable-dml-output-buffering \
        --disable-generics \
	--enable-alignment=128 \
	--enable-tbb-pool-allocator \
        CXXFLAGS=" -I${TBBINCDIR} ${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
  	LDFLAGS="-L${TBBLIBDIR}" LIBS="-ltbb -ltbbmalloc -lpthread -lz" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE} \
	--with-llvm=${INSTALLDIR}/llvm

#	--with-llvm=/home/bjoo/install/llvm-3.9-gcc-6.2.0-shared
#       --with-llvm=/home/bjoo/install/llvm-trunk-intel \

${MAKE}
${MAKE} install

popd
