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

if [ -d ./build_chroma-double ]; 
then 
  rm -rf ./build_chroma-double
fi

if [ ! -d ./build_chroma-double ];
then
 mkdir  ./build_chroma-double
fi

cd ./build_chroma-double

${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma-double \
	--with-qdp=${INSTALLDIR}/qdp++-double \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CFLAGS="${PK_CFLAGS}" \
	CXXFLAGS="-I${TBBINCDIR} -I${VTUNEINCDIR} -O3 -g" CFLAGS=" -O3 -g" \
	LDFLAGS=" -Wl,-zmuldefs -L${TBBLIBDIR} -L${VTUNELIBDIR}"  LIBS="-ltbb -ltbbmalloc -littnotify -lpthread -lz" \
        --enable-jit-clover \
        --host=x86_64-linux-gnu --build=none \
        --with-qphix-solver=${INSTALLDIR}/dslash-avx-s4 \
        --enable-qphix-solver-arch=avx512 \
        --enable-qphix-solver-soalen=4 \
        --enable-qphix-solver-compress12 \
        --enable-qphix-solver-inner-type=f \
        --enable-qphix-solver-inner-soalen=4 \
	--enable-qphix-dslash \
	--enable-static-packed-gauge \
	--enable-ittnotify


${MAKE}
${MAKE} install
popd
