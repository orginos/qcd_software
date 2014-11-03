#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma-double ]; 
then 
  rm -rf ./build_chroma-double
fi

mkdir  ./build_chroma-double
cd ./build_chroma-double

####
#  DISABLE C++ Dslash because of include file conflicts
###
${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma-double \
	--with-qdp=${INSTALLDIR}/qdp++-double \
        --enable-sse2 --enable-sse3 ${OMPENABLE} \
        --with-qmp=${INSTALLDIR}/qmp \
	--with-qphix-solver=${INSTALLDIR}/dslash-avx-s4 \
	--enable-qphix-solver-arch=avx \
	--enable-qphix-solver-soalen=4 \
	--enable-qphix-solver-compress12 \
	--enable-qphix-solver-inner-type=f \
	--enable-qphix-solver-inner-soalen=4 \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" \
	LDFLAGS="-Wl,-zmuldefs" \
        --enable-sse-scalarsite-bicgstab-kernels --host=x86_64-linux-gnu --build=none
${MAKE}
${MAKE} install

popd
