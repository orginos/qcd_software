#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh
pushd ${SRCDIR}/qdp
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qdpc ]; 
then 
  rm -rf ./build_qdpc
fi

mkdir  ./build_qdpc
cd ./build_qdpc


${SRCDIR}/qdp/configure \
	--prefix=${INSTALLDIR}/qdpc \
	--with-qmp=${INSTALLDIR}/qmp \
	--with-qio=${INSTALLDIR}/qio \
	--with-qla=${INSTALLDIR}/qla \
	CFLAGS="${PK_CFLAGS}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
