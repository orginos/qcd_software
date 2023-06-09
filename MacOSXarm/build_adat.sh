#!/bin/bash
#
#################
# BUILD Adat
#################
source env.sh

pushd ${SRCDIR}/adat
autoreconf -f -i 
popd

pushd ${BUILDDIR}

if [ -d ./build_adat ]; 
then 
  rm -rf ./build_adat
fi

mkdir  ./build_adat
cd ./build_adat


${SRCDIR}/adat/configure --prefix=${INSTALLDIR}/adat \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS="-O3 -std=c++11 -I/opt/homebrew/include" \
     LDFLAGS="-L/opt/homebrew/lib "  LIBS="-framework Accelerate -llapack -lblas -lgmpxx -lgmp"

${MAKE}
${MAKE} install

popd
