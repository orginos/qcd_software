#!/bin/bash
#
#################
# BUILD Tensor
#################
source env.sh

pushd ${BUILDDIR}

if [ -d ./build_laplace_eigs ]; 
then 
  rm -rf ./build_laplace_eigs
fi

mkdir  ./build_laplace_eigs
cd ./build_laplace_eigs

pushd ${SRCDIR}/laplace_eigs
git checkout parallel
git branch
popd

cp -p -r ${SRCDIR}/laplace_eigs/* .
\rm -rf Makefile
mv Makefile.in Makefile


export ARCH="QMP"
export PRIMME_ENV=${SCALAR_INSTALLDIR}/primme 
export QDP_CONFIG_ND3_ENV=${INSTALLDIR}/qdp++_3d/bin/qdp++-config 
export QDP_CONFIG_ND4_ENV=${INSTALLDIR}/qdp++/bin/qdp++-config 

make 

if [ -d $INSTALLDIR/laplace_eigs ];
then
  \rm -rf $INSTALLDIR/laplace_eigs
fi

mkdir $INSTALLDIR/laplace_eigs

\cp laplace_eigs vecs_combine_4d vecs_combine_3d $INSTALLDIR/laplace_eigs

popd
