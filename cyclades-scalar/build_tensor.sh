#!/bin/bash
#
#################
# BUILD Tensor
#################
source env.sh

pushd ${SRCDIR}/tensor
./autogen.sh
#autoreconf -f -i 
popd

pushd ${BUILDDIR}

if [ -d ./build_tensor ]; 
then 
  rm -rf ./build_tensor
fi

mkdir  ./build_tensor
cd ./build_tensor


${SRCDIR}/tensor/configure --prefix=${INSTALLDIR}/tensor \
     --without-arpack \
     F77="/usr/bin/gfortran" \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS="-I ${INSTALLDIR}/atlas/include" \
     CFLAGS="-I ${INSTALLDIR}/atlas/include" \
     LDFLAGS="-L ${INSTALLDIR}/atlas/lib"  \
     LIBS="-lm -llapack -lcblas -latlas"

#     LDFLAGS="-L ${INSTALLDIR}/atlas/lib"  
#     ${OMPENABLE} 

${MAKE}
${MAKE} install

popd
