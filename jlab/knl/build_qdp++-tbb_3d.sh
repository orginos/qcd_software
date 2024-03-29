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

if [ -d ./build_qdpxx-parscalar-avx_3d ]; 
then 
  rm -rf ./build_qdpxx-parscalar-avx_3d
fi

mkdir  ./build_qdpxx-parscalar-avx_3d
cd ./build_qdpxx-parscalar-avx_3d


${SRCDIR}/qdpxx/configure \
	--prefix=${INSTALLDIR}/qdp++_3d \
        --enable-Nd=3 \
        --enable-parallel-arch=parscalar \
	--enable-precision=single \
        --enable-filedb \
	--disable-generics \
        --enable-largefile \
        --enable-parallel-io \
        --enable-alignment=64 \
	--with-qmp=${INSTALLDIR}/qmp \
	--with-libxml2=${INSTALLDIR}/libxml2\
	CXXFLAGS="${PK_CXXFLAGS} -I${TBBINCDIR} -g" \
	CFLAGS="${PK_CFLAGS}" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	LDFLAGS="-L${TBBLIBDIR}" LIBS="-ltbb -ltbbmalloc -lpthread" \
        ${OMPENABLE} \
        --host=x86_64-linux-gnu --build=none \
        --enable-tbb-pool-allocator

${MAKE}
${MAKE} install

#--host=x86_64-linux-gnu --build=none \

popd
