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

if [ -d ./build_primme ]; 
then 
  rm -rf ./build_primme
fi

mkdir  ./build_primme
cd ./build_primme


export PRIMME_LDFLAGS="-framework Accelerate"
export PRIMME_LIBS=" -lprimme -lm -llapack -lblas" 
export TOP="${BUILDDIR}/build_primme"

export PK_CC
export PK_F77
export PK_CFLAGS
export INSTALLDIR

cp -r ${SRCDIR}/primme/* .


#${MAKE} 
#${MAKE} install

make lib
make config
make install

popd
