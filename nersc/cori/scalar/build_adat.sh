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
     CXXFLAGS="-std=c++11 -I ${INSTALLDIR}/atlas/include" \
     LDFLAGS="-L ${INSTALLDIR}/atlas/lib"  \
     LIBS="-lm -llapack -latlas"

${MAKE}
${MAKE} install

popd
