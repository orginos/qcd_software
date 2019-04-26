#!/bin/bash

source ./env.sh


pushd ${BUILDDIR}

if [ -d ./build_llvm_6.0 ]; 
then 
  rm -rf ./build_llvm_6.0
fi

sync

mkdir  ./build_llvm_6.0
pushd ./build_llvm_6.0

cmake -G "Unix Makefiles" \
-DCMAKE_CXX_FLAGS="${PK_LLVM_CXXFLAGS}" \
-DCMAKE_CXX_COMPILER=${PK_LLVM_CXX} \
-DCMAKE_CXX_LINK_FLAGS="-Wl,-rpath,${GCC_HOME}/lib64 -L${GCC_HOME}/lib64" \
-DLLVM_ENABLE_TERMINFO="OFF" \
-DCMAKE_C_COMPILER=${PK_LLVM_CC} \
-DCMAKE_C_FLAGS=${PK_LLVM_CFLAGS} \
-DCMAKE_BUILD_TYPE=Debug \
-DCMAKE_INSTALL_PREFIX=${LLVM_INSTALL_DIR} \
-DLLVM_TARGETS_TO_BUILD="${QDPJIT_HOST_ARCH}" \
-DLLVM_ENABLE_ZLIB="OFF" \
-DBUILD_SHARED_LIBS="ON" \
-DLLVM_ENABLE_RTTI="ON"  \
${SRCDIR}/llvm-6.0.0.src


${MAKE}
${MAKE} install
popd
