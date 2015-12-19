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

GMP=/dist/gmp-6.0.0

${SRCDIR}/adat/configure --prefix=${INSTALLDIR}/adat \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS=" ${PK_CXXFLAGS} -I ${GMP}/include " \
     LIBS="$GMP/lib/libgmpxx.a $GMP/lib/libgmp.a"

# LDFLAGS="-L ${GMP}/lib"  \
#     LIBS="-lgmpxx -lgmp"

${MAKE}
${MAKE} install

popd
