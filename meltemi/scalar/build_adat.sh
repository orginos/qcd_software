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

GMP=${INSTALLDIR}/gmp

${SRCDIR}/adat/configure --prefix=${INSTALLDIR}/adat \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS=" ${PK_CXXFLAGS} -I${GMP}/include" \
    LDFLAGS="-L ${GMP}/lib"  \
    --host=x86_64-linux-gnu 
    LIBS="-lgmpxx -lgmp" 

#    LIBS="$GMP/lib/libgmpxx.a $GMP/lib/libgmp.a"

#-I ${GMP}/include " \
#     LIBS="$GMP/lib64/libgmpxx.a $GMP/lib64/libgmp.a"

# LDFLAGS="-L ${GMP}/lib"  \
#     LIBS="-lgmpxx -lgmp"

${MAKE}
${MAKE} install

popd
