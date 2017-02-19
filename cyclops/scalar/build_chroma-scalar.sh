#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
aclocal; automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma-scalar ]; 
then 
  rm -rf ./build_chroma-scalar
fi

mkdir  ./build_chroma-scalar
cd ./build_chroma-scalar


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma-scalar \
	--with-qdp=${INSTALLDIR}/qdp++-scalar \
        --enable-cpp-wilson-dslash  ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
        LIBS="-llapack -lblas" \
	CXXFLAGS="" CFLAGS="" \
        --host=x86_64-linux-gnu --build=none
${MAKE}
${MAKE} install

popd
