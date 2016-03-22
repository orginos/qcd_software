#!/bin/bash
#
#################
# BUILD Harom
#################
source env.sh




LLVMPATH=${SRCDIR}/llvm-3.4
pushd $LLVMPATH
autoreconf -f -i
popd

pushd ${BUILDDIR}

if [ -d ./build_llvm ]; 
then 
  rm -rf ./build_llvm
fi

mkdir  ./build_llvm
cd ./build_llvm

$LLVMPATH/configure \
    --prefix=${INSTALLDIR}/llvm  \
    --enable-shared \
    --disable-terminfo \
    --disable-zlib \
    --enable-targets="x86_64,nvptx" \
    CC="${PK_CC}" \
    CXX="${PK_CXX}" \
    CFLAGS="$PK_CFLAGS" \
    CXXFLAGS="$PK_CXXFLAGS"

${MAKE}
${MAKE} install

popd
