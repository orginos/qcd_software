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
#    F77="/shared/gcc-5.3.0/bin/bin/gfortran" \
#    CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS="-I/usr/include/atlas" \
     CFLAGS="-I/usr/include/atlas" \
     LDFLAGS="-L/usr/lib64/atlas"  \
     LIBS="-lm -llapack -lcblas -latlas"

#     LDFLAGS="-L ${INSTALLDIR}/atlas/lib"  
#     ${OMPENABLE} 

${MAKE}
${MAKE} install

popd
