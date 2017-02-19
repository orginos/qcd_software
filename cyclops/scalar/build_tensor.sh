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
     --with-arpack \
    --with-backend=atlas \
    F77="/shared/gcc-5.3.0/bin/gfortran" \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS="-I${INSTALLDIR}/atlas" \
     CFLAGS="-I${INSTALLDIR}/atlas" \
     LDFLAGS="-L${INSTALLDIR}/atlas/lib"  \
     LIBS="-lm -llapack -lcblas -latlas" \
     ${OMPENABLE}

${MAKE}
${MAKE} install

popd
