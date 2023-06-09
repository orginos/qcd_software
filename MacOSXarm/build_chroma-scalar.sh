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

if [ -d ./build_chroma-scalar ]; 
then 
  rm -rf ./build_chroma-scalar
fi

mkdir  ./build_chroma-scalar
cd ./build_chroma-scalar


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma/scalar \
	--with-qdp=${INSTALLDIR}/qdp++/scalar \
        ${OMPENABLE} \
	--enable-cpp-wilson-dslash ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS=""  \
        LIBS=" -llapack -lblas -framework Accelerate"
       

${MAKE}
${MAKE} install

popd
