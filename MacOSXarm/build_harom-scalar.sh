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

if [ -d ./build_harom-scalar ]; 
then 
  rm -rf ./build_harom-scalar
fi

mkdir  ./build_harom-scalar
cd ./build_harom-scalar


${SRCDIR}/harom/configure --prefix=${INSTALLDIR}/harom/scalar \
        --with-hadron=${INSTALLDIR}/hadron \
	--with-qdp=${INSTALLDIR}/qdp++/scalar_3d \
        --enable-sse2 --enable-sse3 ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" 


${MAKE}
${MAKE} install

popd
