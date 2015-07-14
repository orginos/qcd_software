#!/bin/bash
#
#################
# BUILD Harom
#################
source env.sh

pushd ${SRCDIR}/harom
autoreconf -f -i
popd

pushd ${BUILDDIR}

if [ -d ./build_harom ]; 
then 
  rm -rf ./build_harom
fi

mkdir  ./build_harom
cd ./build_harom


${SRCDIR}/harom/configure --prefix=${INSTALLDIR}/harom \
        --with-hadron=${SCALAR_INSTALLDIR}/hadron \
	--with-qdp=${INSTALLDIR}/qdp++_3d \
        --enable-sse2 --enable-sse3 ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" 


${MAKE}
${MAKE} install

popd
