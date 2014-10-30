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
	--with-qdp=${INSTALLDIR}/qdp++-parscalar-double \
        ${OMPENABLE} \
        --with-qmp=${INSTALLDIR}/qmp \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" \
	LDFLAGS="-Wl,-zmuldefs" \
       --with-intel-solver=${INSTALLDIR}/dslash-mic-s8 \
       --enable-intel-solver-arch=mic \
       --enable-intel-solver-soalen=8 \
       --enable-intel-solver-compress12 \
	--enable-intel-solver-inner-type=half \
	--enable-intel-solver-inner-soalen=8 \
       --enable-c-scalarsite-bicgstab-kernels --host=x86_64-linux-gnu --build=none

${MAKE}
${MAKE} install
popd
