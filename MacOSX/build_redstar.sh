#!/bin/bash
#
#################
# BUILD Adat
#################
source env.sh

pushd ${SRCDIR}/adat
autoreconf -f -i 
popd

pushd ${BUILDDIR}

if [ -d ./build_redstar ]; 
then 
  rm -rf ./build_redstar
fi

mkdir  ./build_redstar
cd ./build_adat


${SRCDIR}/adat/configure --prefix=${INSTALLDIR}/redstar \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
     CXXFLAGS=" " \
     LDFLAGS=" "  LIBS="-framework Accelerate -llapack -lblas"

${MAKE}
${MAKE} install

popd
