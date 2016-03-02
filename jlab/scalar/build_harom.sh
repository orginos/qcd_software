#!/bin/bash
#
#################
# BUILD Harom
#################
source env.sh

pushd ${SRCDIR}/harom
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_harom ]; 
then 
  rm -rf ./build_harom
fi

mkdir  ./build_harom
cd ./build_harom


${SRCDIR}/harom/configure --prefix=${INSTALLDIR}/harom \
        --with-hadron=${INSTALLDIR}/hadron \
	--with-qdp=${INSTALLDIR}/qdp++_3d \
        --enable-sse2 --enable-sse3 ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" \
        --host=x86_64-linux-gnu --build=none

${MAKE}
${MAKE} install

popd
