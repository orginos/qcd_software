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


${SRCDIR}/ATLAS/configure -C ic gcc -C sm gcc -C dm gcc -C sk gcc -C dk gcc -C gc gcc --with-netlib-lapack-tarfile=$SRCDIR/lapack-3.7.0.tgz  --prefix=${INSTALLDIR}/atlas 
#${SRCDIR}/ATLAS/configure  --with-netlib-lapack-tarfile=$SRCDIR/lapack-3.7.0.tgz --prefix=${INSTALLDIR}/atlas -b 64 -Fa alg '-fopenmp'   -Si archdef 1  -Si latune 1 -tl 16 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 -Si omp 1


${MAKE}
${MAKE} time
${MAKE} install

popd
