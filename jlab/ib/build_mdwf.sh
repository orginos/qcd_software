#!/bin/bash
#
#################
# BUILD MDWF
#################
source env.sh

pushd ${BUILDDIR}

if [ -d ./build_mdwf ]; 
then 
  rm -rf ./build_mdwf
fi

mkdir  ./build_mdwf
cd ./build_mdwf
cp -r ${SRCDIR}/mdwf-1.1.4/* .

export CC="${PK_CC}"
export CFLAGS="${PK_CFLAGS}"
./configure --prefix=${INSTALLDIR}/mdwf --with-qmp=${INSTALLDIR}/qmp --target=c99-64

${MAKE}

${MAKE} install

popd
