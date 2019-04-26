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
     CXXFLAGS="${PK_CXXFLAGS} " \
    --with-libxml2=${INSTALLDIR}/libxml2/bin/xml2-config

#     LDFLAGS="-L ${INSTALLDIR}/atlas/lib"  \
#     LIBS="-lm -llapack -lbla"

${MAKE}
${MAKE} install

popd
