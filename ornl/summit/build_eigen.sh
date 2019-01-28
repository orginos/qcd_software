#!/bin/bash

source ./env.sh


pushd ${BUILDDIR}

if [ -d ./build_eigen ]; 
then 
  rm -rf ./build_eigen
fi

sync

mkdir  ./build_eigen
pushd ./build_eigen

cmake -DCMAKE_C_COMPILER=${PK_LLVM_CC} \
    -DCMAKE_C_FLAGS=${PK_LLVM_CFLAGS} \
    -DCMAKE_CXX_LINK_FLAGS="-Wl,-rpath,${GCC_HOME}/lib64 -L${GCC_HOME}/lib64" \
    -DCMAKE_CXX_FLAGS="${PK_LLVM_CXXFLAGS}" \
    -DCMAKE_CXX_COMPILER=${PK_LLVM_CXX} \
    -DCMAKE_INSTALL_PREFIX=${EIGEN_INSTALL_DIR} ${SRCDIR}/eigen


${MAKE}
${MAKE} install
popd
