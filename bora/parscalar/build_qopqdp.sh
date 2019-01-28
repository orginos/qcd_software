#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh
pushd ${SRCDIR}/qopqdp
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qopqdp ]; 
then 
  rm -rf ./build_qopqdp
fi

mkdir  ./build_qopqdp
cd ./build_qopqdp


${SRCDIR}/qopqdp/configure \
	--prefix=${INSTALLDIR}/qopqdp \
	--with-qmp=${INSTALLDIR}/qmp \
	--with-qio=${INSTALLDIR}/qio \
	--with-qla=${INSTALLDIR}/qla \
	--with-qdp=${INSTALLDIR}/qdpc \
	CFLAGS="-DQDP_PROFILE ${PK_CFLAGS}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

${MAKE}
${MAKE} install

popd
