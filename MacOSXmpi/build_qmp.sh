#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${SRCDIR}/qmp
autoreconf -f -i
popd

pushd ${BUILDDIR}

if [ -d ./build_qmp ]; 
then 
  rm -rf ./build_qmp
fi

mkdir  ./build_qmp
cd ./build_qmp

${SRCDIR}/qmp/configure --prefix=${INSTALLDIR}/qmp-mpi --with-qmp-comms-type=mpi --with-qmp-comms-cflags="" --with-qmp-comms-ldflags="-L/usr/local/lib " --with-qmp-comms-libs="-lmpi" CC="${PK_CC}" CFLAGS="${PK_CFLAGS}" --host=x86_64-linux-gnu --build=none

${MAKE}

${MAKE} install

popd
