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

GMP=/usr

${SRCDIR}/adat/configure --prefix=${INSTALLDIR}/adat \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    CXXFLAGS=" ${PK_CXXFLAGS} " \
    LIBS="$GMP/lib64/libgmpxx.a $GMP/lib64/libgmp.a"

#-I ${GMP}/include " \
#     LIBS="$GMP/lib64/libgmpxx.a $GMP/lib64/libgmp.a"

# LDFLAGS="-L ${GMP}/lib"  \
#     LIBS="-lgmpxx -lgmp"

${MAKE}
${MAKE} install

popd
