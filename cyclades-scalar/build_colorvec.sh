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
    --with-adat=${INSTALLDIR}/adat \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS="${PK_CXXFLAGS} " 

${MAKE}
${MAKE} install

popd
