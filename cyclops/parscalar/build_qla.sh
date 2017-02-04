#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qla
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qla ]; 
then 
  rm -rf ./build_qla
fi

mkdir  ./build_qla
cd ./build_qla


${SRCDIR}/qla/configure \
	--prefix=${INSTALLDIR}/qla \
	--enable-sse3 \
	CFLAGS="${PK_CFLAGS}" \
	CC="${PK_CC}" \
	TEST_CFLAGS="${PK_CFLAGS}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
