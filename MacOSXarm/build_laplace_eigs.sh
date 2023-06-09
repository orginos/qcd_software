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

cp -p -r ${SRCDIR}/laplace_eigs/* .
mv Makefile Makefile.orig
cat Makefile.orig | sed 's/ARCH =/#ARCH/;s/^QDP_CONFIG/#QDP_CONFIG/;s/^PRIMME/#PRIME/' >Makefile


export ARCH=macosx 
export PRIMME=/usr/local/scidac/primme 
export QDP_CONFIG_ND3=/usr/local/scidac/qdp++/scalar_3d/bin/qdp++-config 
export QDP_CONFIG_ND4=/usr/local/scidac/qdp++/scalar/bin/qdp++-config 

make 

mkdir $INSTALLDIR/laplace_eigs

\cp laplace_eigs vecs_combine_4d vecs_combine_3d $INSTALLDIR/laplace_eigs

popd
