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
 sleep 2
fi
#
mkdir  ./build_chroma-double
cd ./build_chroma-double

####
#  DISABLE C++ Dslash because of include file conflicts
###
${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma-double \
	--with-qdp=${INSTALLDIR}/qdp++-double \
	--with-qmp=${INSTALLDIR}/qmp \
	--enable-cpp-wilson-dslash --enable-sse2 \
         ${OMPENABLE} \
        --with-qphix-solver=${INSTALLDIR}/qphix-double_avx512 \
        --enable-qphix-solver-arch=avx512 \
        --enable-qphix-solver-soalen=4 \
        --enable-qphix-solver-compress12 \
        --enable-qphix-solver-inner-type=f \
        --enable-qphix-solver-inner-soalen=4 \
	--enable-static-packed-gauge \
	--enable-fused-clover-deriv-loops \
       CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="${PK_CXXFLAGS} -g" CFLAGS="${PK_CFLAGS}" \
	LDFLAGS="-dynamic -Wl,-zmuldefs  -L${TBBLIBDIR}" LIBS=" -ltbb -ltbbmalloc -lpthread" \
        --host=x86_64-linux-gnu --build=none

#       --enable-static-packed-gauge \
#       --enable-fused-clover-deriv-loops \


${MAKE}
${MAKE} install

#  LDFLAGS="-Wl,-zmuldefs  -L${VTUNELIBDIR} -L${TBBINCDIR}" LIBS=" -ltbb -ltbbmalloc -littnotify -lpthread" \
#

#       --with-qmp=${INSTALLDIR}/qmp \
#        --with-qphix-solver=${INSTALLDIR}/dslash-avx-s4 \
#        --enable-qphix-solver-arch=avx512 \
#        --enable-qphix-solver-soalen=4 \
#        --enable-qphix-solver-compress12 \
#       --enable-qphix-solver-inner-type=f \
#        --enable-qphix-solver-inner-soalen=4 \
# --enable-sse-scalarsite-bicgstab-kernels   \
popd
