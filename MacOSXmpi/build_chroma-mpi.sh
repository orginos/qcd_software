#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
autoupdate
autoreconf -f -i 
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma-mpi ]; 
then 
  rm -rf ./build_chroma-mpi
fi

mkdir  ./build_chroma-mpi
cd ./build_chroma-mpi


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma/mpi \
	--with-qdp=${INSTALLDIR}/qdp++/mpi \
        ${OMPENABLE} \
	--with-superbblas=${SRCDIR}/superbblas \
	--enable-cpp-wilson-dslash ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
        LIBS=" -llapack -lblas -framework Accelerate"
       

${MAKE}
${MAKE} install

popd
#	
