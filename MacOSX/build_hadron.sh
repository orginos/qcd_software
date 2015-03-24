#!/bin/bash
#
#################
# BUILD Hardron
#################
source env.sh

pushd ${SRCDIR}/hadron
autoreconf -f
popd

pushd ${BUILDDIR}

if [ -d ./build_hadron ]; 
then 
  rm -rf ./build_hadron
fi

mkdir  ./build_hadron
cd ./build_hadron


${SRCDIR}/hadron/configure --prefix=${INSTALLDIR}/hadron \
        --with-tensor="${INSTALLDIR}/tensor" \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="-O3 -std=c++0x" CFLAGS="" \
        --host=x86_64-linux-gnu --build=none
${MAKE}
${MAKE} install

popd
