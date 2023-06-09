#!/bin/bash
#
#################
# BUILD Colorvec
#################
source env.sh

pushd ${SRCDIR}/colorvec
autoreconf -f -i 
popd

pushd ${BUILDDIR}

if [ -d ./build_colorvec ]; 
then 
  rm -rf ./build_colorvec
fi

mkdir  ./build_colorvec
cd ./build_colorvec


${SRCDIR}/colorvec/configure --prefix=${INSTALLDIR}/colorvec \
    --with-hadron=${INSTALLDIR}/hadron \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS=" " \
     LDFLAGS=" "  LIBS="-framework Accelerate -llapack -lblas"

${MAKE}
${MAKE} install

popd
