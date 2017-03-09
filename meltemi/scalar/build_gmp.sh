#!/bin/bash
#
#################
# BUILD GMP
#################
source env.sh

pushd ${BUILDDIR}

if [ -d ./build_gmp ]; 
then 
  rm -rf ./build_gmp
fi

mkdir  ./build_gmp
cd ./build_gmp

${SRCDIR}/libxml2/configure --prefix=${INSTALLDIR}/gmp -host=x86_64-unknown-linux \
    --build=x86_64-suse-linux \
    CC="${PK_CC}" \
    CFLAGS="${PK_CFLAGS}" 



${MAKE}
${MAKE} install

popd
