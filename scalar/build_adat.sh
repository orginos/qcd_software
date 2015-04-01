#!/bin/bash
#
#################
# BUILD Adat
#################
source env.sh

pushd ${SRCDIR}/adat
#autoreconf -f -i 
aclocal;automake;autoconf
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
     CXXFLAGS="${PK_CXXFLAGS}" \
     CFLAGS="${PK_CFLAGS}" \
     LDFLAGS=" "  LIBS=" "

${MAKE}
${MAKE} install

popd
