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
     --enable-threadsafe-deathtest \
     --with-backend=mkl \
     F77="$PK_FC" \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS="${PK_CXXFLAGS} -xAVX" \
     CFLAGS="${PK_CFLAGS} -xAVX" \
     FFLAGS="${PK_FCFLAGS} -xAVX" \
     LIBS="" \
     ${OMPENABLE}

${MAKE}
${MAKE} install

popd
