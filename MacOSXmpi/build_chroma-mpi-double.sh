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

if [ -d ./build_chroma-mpi-double ]; 
then 
  rm -rf ./build_chroma-mpi-double
fi

mkdir  ./build_chroma-mpi-double
cd ./build_chroma-mpi-double


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma/mpi-double \
	--with-qdp=${INSTALLDIR}/qdp++/mpi-double \
        ${OMPENABLE} \
	--with-superbblas=${SRCDIR}/superbblas \
	--enable-cpp-wilson-dslash ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
        LIBS=" -llapack -lblas -framework Accelerate"
       

${MAKE}
${MAKE} install

popd
#	
