#!/bin/bash
#
#################
# BUILD Adat
#################
source env.sh

pushd ${SRCDIR}/ATLAS
#autoreconf -f -i 
#aclocal;automake;autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_atlas ]; 
then 
  rm -rf ./build_atlas
fi

mkdir  ./build_atlas
cd ./build_atlas


${SRCDIR}/ATLAS/configure -C ic gcc -C sm gcc -C dm gcc -C sk gcc -C dk gcc -C gc gcc   --prefix=${INSTALLDIR}/atlas 


${MAKE}
${MAKE} time
${MAKE} install

popd
