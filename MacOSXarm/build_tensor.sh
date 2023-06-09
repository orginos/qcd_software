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
     --with-arpack \
     F77="gfortran" \
     ${OMPENABLE} \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS=" " \
     LDFLAGS=" "  LIBS="-framework Accelerate -llapack -lblas"

${MAKE}
${MAKE} install

popd
