#!/bin/bash
#
#################
# BUILD itpp
#################
source env.sh

module unload cmake
module load  cmake/3.0.0
module load fftw


pushd ${BUILDDIR}

if [ -d ./build_itpp ]; 
then 
  rm -rf ./build_itpp
fi

mkdir  ./build_itpp
cd ./build_itpp



export LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:${INSTALLDIR}/atlas/lib:$FFTW_DIR

cmake -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/itpp -DITPP_SHARED_LIB=off -DBLA_VENDOR=ATLAS -DFFT_LIBRARIES=$FFTW_DIR -DFFT_INCLUDES=$FFTW_INC ${SRCDIR}/itpp-4.3.1



${MAKE}
${MAKE} install

popd

