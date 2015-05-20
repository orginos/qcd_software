#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qio
autoreconf -f
automake --add-missing
popd

pushd ${BUILDDIR}

if [ -d ./build_qio ]; 
then 
  rm -rf ./build_qio
fi

mkdir  ./build_qio
cd ./build_qio


${SRCDIR}/qio/configure \
	--prefix=${INSTALLDIR}/qio \
	--enable-largefile \
	--enable-dml-output-buffering \
	--with-qmp=${INSTALLDIR}/qmp \
	CFLAGS="${PK_CFLAGS}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
