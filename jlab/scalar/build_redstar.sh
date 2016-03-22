#!/bin/bash
#
#################
# BUILD redstar
#################
source env.sh

pushd ${SRCDIR}/redstar
./autogen.sh
autoreconf -f -i
popd

pushd ${BUILDDIR}

if [ -d ./build_redstar ]; 
then 
  rm -rf ./build_redstar
fi

mkdir  ./build_redstar
cd ./build_redstar


${SRCDIR}/redstar/configure --prefix=${INSTALLDIR}/redstar \
     CC="${PK_CC}"  CXX="${PK_CXX}" \
    --with-hadron=${INSTALLDIR}/hadron \
    --with-adat=${INSTALLDIR}/adat \
     CXXFLAGS="${PK_CXXFLAGS} " 

${MAKE}
${MAKE} install

popd
