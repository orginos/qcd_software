#!/bin/bash
#
#################
# BUILD Tensor
#################
source env.sh

pushd ${SRCDIR}/tensor
autoreconf -f -i 
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
     F77="gfortran" \
     ${OMPENABLE} \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS="-I ${INSTALLDIR}/atlas/include" \
     LDFLAGS="-L ${INSTALLDIR}/atlas/lib"  \
     LIBS="-lm -llapack -lcblas -latlas"

${MAKE}
${MAKE} install

popd
