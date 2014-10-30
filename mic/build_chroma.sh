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
	--with-qdp=${INSTALLDIR}/qdp++-parscalar \
        ${OMPENABLE} \
        --with-qmp=${INSTALLDIR}/qmp \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" \
	LDFLAGS="-Wl,-zmuldefs" \
       --with-qphix-solver=${INSTALLDIR}/dslash-mic-s8 \
       --enable-qphix-solver-arch=mic \
       --enable-qphix-solver-soalen=8 \
       --enable-qphix-solver-compress12 \
	--enable-qphix-solver-inner-type=half \
	--enable-qphix-solver-inner-soalen=8 \
	--enable-cpp-wilson-dslash \
       --enable-c-scalarsite-bicgstab-kernels --host=x86_64-linux-gnu --build=none

${MAKE}
${MAKE} install
popd
