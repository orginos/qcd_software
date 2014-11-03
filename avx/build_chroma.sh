#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma ]; 
then 
  rm -rf ./build_chroma
fi

mkdir  ./build_chroma
cd ./build_chroma

####
#  DISABLE C++ Dslash because of include file conflicts
###
${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma \
	--with-qdp=${INSTALLDIR}/qdp++ \
         --enable-cpp-wilson-dslash --enable-sse2 --enable-sse3 ${OMPENABLE} \
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
