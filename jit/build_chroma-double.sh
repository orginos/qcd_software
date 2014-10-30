#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma-double ]; 
then 
  rm -rf ./build_chroma-double
fi

mkdir  ./build_chroma-double
cd ./build_chroma-double


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma-double \
	--with-qdp=${INSTALLDIR}/qdp++-double \
        ${OMPENABLE} \
        --with-qmp=${INSTALLDIR}/qmp \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="" \
        --host=x86_64-linux-gnu --build=none \
	--enable-jit-clover \
        --with-cuda=${PK_CUDA_HOME} \
        --enable-quda-deviface \
        --with-quda=${INSTALLDIR}/quda_qdp_double
${MAKE}
${MAKE} install

popd
