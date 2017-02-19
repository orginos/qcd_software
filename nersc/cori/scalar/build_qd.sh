#!/bin/bash
#
#################
# BUILD Tensor
#################
source env.sh

pushd ${SRCDIR}/qd
autoreconf -f -i 
popd

pushd ${BUILDDIR}

if [ -d ./build_qd ]; 
then 
  rm -rf ./build_qd
fi

mkdir  ./build_qd
cd ./build_qd


${SRCDIR}/qd/configure --prefix=${INSTALLDIR}/qd \
     F77="gfortran" \
     ${OMPENABLE} \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS="" \
     LDFLAGS=""  \
     LIBS=""

${MAKE}
${MAKE} install

popd
