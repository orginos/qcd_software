#!/bin/bash
#
#################
# BUILD Tensor
#################
source env.sh

pushd ${BUILDDIR}

if [ -d ./build_mg_vecs ]; 
then 
  rm -rf ./build_mg_vecs
fi

mkdir  ./build_mg_vecs
cd ./build_mg_vecs

pushd ${SRCDIR}/mg_vecs
git branch
popd

cp -p -r ${SRCDIR}/mg_vecs/* .
\rm -rf Makefile
mv Makefile.in Makefile


export PRIMME_ENV=${INSTALLDIR}/primme 
export QDP_CONFIG_ND3_ENV=${INSTALLDIR}/qdp++-scalar_3d/bin/qdp++-config 
export QDP_CONFIG_ND4_ENV=${INSTALLDIR}/qdp++-scalar/bin/qdp++-config 

make 

if [ -d $INSTALLDIR/mg_vecs ];
then
  \rm -rf $INSTALLDIR/mg_vecs
fi

mkdir $INSTALLDIR/mg_vecs

\cp mg_evecs $INSTALLDIR/mg_vecs

popd
