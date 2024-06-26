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

if [ -d ./build_chroma_noqphix ]; 
then 
 rm -rf ./build_chroma_noqphix
 sleep 2
fi
#
mkdir  ./build_chroma_noqphix
cd ./build_chroma_noqphix

####
#  DISABLE C++ Dslash because of include file conflicts
###
${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma_noqphix \
	--with-qdp=${INSTALLDIR}/qdp++ \
	--with-qmp=${INSTALLDIR}/qmp \
         ${OMPENABLE} \
        --enable-cpp-wilson-dslash --enable-sse2 \
        --enable-sse-scalarsite-bicgstab-kernels \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="${PK_CXXFLAGS} -I${VTUNEINCDIR} -g" CFLAGS="${PK_CFLAGS}" \
	LDFLAGS="-Wl,-zmuldefs  -L${VTUNELIBDIR} -L${TBBINCDIR}" LIBS=" -ltbb -ltbbmalloc -littnotify -lpthread" \
        --host=x86_64-linux-gnu --build=none

#       --enable-static-packed-gauge \
#       --enable-fused-clover-deriv-loops \


${MAKE}

${MAKE} install
#  LDFLAGS="-Wl,-zmuldefs  -L${VTUNELIBDIR} -L${TBBINCDIR}" LIBS=" -ltbb -ltbbmalloc -littnotify -lpthread" \
#${MAKE} install

#       --with-qmp=${INSTALLDIR}/qmp \
#        --with-qphix-solver=${INSTALLDIR}/dslash-avx-s4 \
#        --enable-qphix-solver-arch=avx512 \
#        --enable-qphix-solver-soalen=4 \
#        --enable-qphix-solver-compress12 \
#       --enable-qphix-solver-inner-type=f \
#        --enable-qphix-solver-inner-soalen=4 \
# --enable-sse-scalarsite-bicgstab-kernels   \
popd
