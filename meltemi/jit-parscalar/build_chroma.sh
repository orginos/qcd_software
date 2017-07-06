#!/bin/bash
#
#################
# BUILD Chroma
#################
source ./env.sh

pushd ${SRCDIR}/chroma
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma ]; 
then 
  rm -rf ./build_chroma
fi

if [ ! -d ./build_chroma ];
then
 mkdir  ./build_chroma
fi

cd ./build_chroma

${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma \
	--with-qdp=${INSTALLDIR}/qdp++ \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="${PK_CFLAGS}" \
        LDFLAGS="-Wl,-zmuldefs" LIBS="-lz" \
        --enable-jit-clover \
        --host=x86_64-linux-gnu --build=none \
        --with-qphix-solver=${INSTALLDIR}/qphix_avx512 \
        --enable-qphix-solver-arch=avx \
        --enable-qphix-solver-soalen=4 \
        --enable-qphix-solver-compress12 \
        --enable-qphix-solver-inner-type=f \
        --enable-qphix-solver-inner-soalen=4


${MAKE}
${MAKE} install
popd
