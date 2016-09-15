#!/bin/bash
#
#################
# BUILD Tensor
#################
source env.sh

pushd ${SRCDIR}/arprec
autoreconf -f -i 
popd

pushd ${BUILDDIR}

if [ -d ./build_arprec ]; 
then 
  rm -rf ./build_arprec
fi

mkdir  ./build_arprec
cd ./build_arprec


${SRCDIR}/arprec/configure --prefix=${INSTALLDIR}/arprec \
     F77="gfortran" \
     ${OMPENABLE} \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS="" \
     LDFLAGS=""  \
     LIBS=""

${MAKE}
${MAKE} install

popd
