#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

# Brought back chroma-ji
# as a specific version of chroma is needed
# until QDP-JIT catches up with QDPXX

pushd ${SRCDIR}/chroma
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma ]; 
then 
  rm -rf ./build_chroma
fi

mkdir  ./build_chroma
cd ./build_chroma


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma \
	--with-qdp=${INSTALLDIR}/qdp++ \
        ${OMPENABLE} \
        --with-qmp=${INSTALLDIR}/qmp \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" \
        --host=x86_64-linux-gnu --build=none \
	--enable-quda-deviface \
	--enable-jit-clover \
        --with-quda=${INSTALLDIR}/quda_qdp_single \
        --with-cuda=${PK_CUDA_HOME}
${MAKE}
${MAKE} install

popd
