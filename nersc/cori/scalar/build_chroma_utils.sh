#!/bin/bash
#
#################
# BUILD Chroma_Utils
#################
source env.sh

pushd ${SRCDIR}/chroma_utils
autoreconf -f -i 
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma_utils ]; 
then 
  rm -rf ./build_chroma_utils
fi

mkdir  ./build_chroma_utils
cd ./build_chroma_utils


${SRCDIR}/chroma_utils/configure --prefix=${INSTALLDIR}/chroma_utils \
    CC="${PK_CC}"  CXX="${PK_CXX}" \
    --with-libxml2=${INSTALLDIR}/libxml2 \
    CXXFLAGS="${PK_CXXFLAGS}"
#    CXXFLAGS="-std=c++11 -I ${INSTALLDIR}/atlas/include" \
#    LDFLAGS="-L ${INSTALLDIR}/atlas/lib"  \
#    LIBS="-lm -llapack -latlas"

${MAKE}
${MAKE} install

popd
