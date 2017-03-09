#!/bin/bash
#
#################
# BUILD Primme
#################
source env.sh

#pushd ${SRCDIR}/primme
#autoreconf -f -i 
#popd

pushd ${BUILDDIR}

if [ -d ./build_primme_v1.2 ]; 
then 
  rm -rf ./build_primme_v1.2
fi

mkdir  ./build_primme_v1.2
cd ./build_primme_v1.2


export PRIMME_LDFLAGS="-L${MKLROOT}/lib/intel64"
export PRIMME_LIBS=" -lprimme -lm -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_ilp64.a ${MKLROOT}/lib/intel64/libmkl_sequential.a ${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group" 
export TOP="${BUILDDIR}/build_primme"

export PK_CC
export PK_F77
export PK_CFLAGS
export INSTALLDIR

export TOP=$PWD

cp -r ${SRCDIR}/primme_v1.2/* .


#${MAKE} 
#${MAKE} install

make lib
make config
make install

popd
