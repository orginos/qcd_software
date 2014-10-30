#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${BUILDDIR}

if [ -d ./build_qmp ]; 
then 
  rm -rf ./build_qmp
fi

mkdir  ./build_qmp
cd ./build_qmp

${SRCDIR}/qmp/configure --prefix=${INSTALLDIR}/qmp --with-qmp-comms-type=MPI --with-qmp-comms-cflags="" --with-qmp-comms-ldflags="" --with-qmp-comms-libs="" CC="${PK_CC}" CFLAGS="${PK_CFLAGS}" --host=x86_64-linux-gnu --build=none

${MAKE}

${MAKE} install

popd
