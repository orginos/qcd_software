#!/bin/bash
#
#################
# BUILD Hardron
#################
source env.sh

pushd ${SRCDIR}/hadron
autoreconf -f -i
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
	CXXFLAGS="${PK_CXXFLAGS}" CFLAGS="${PK_CFLAGS}"

${MAKE}
${MAKE} install

popd
