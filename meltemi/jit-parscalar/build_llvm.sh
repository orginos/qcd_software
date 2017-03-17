#!/bin/bash
#
#################
# BUILD LLVM
#################
source ./env.sh

pushd ${BUILDDIR}

if [ -d ./build_llvm ]; 
then 
 rm -rf ./build_llvm
 sleep 2
fi

mkdir  ./build_llvm
cd ./build_llvm



CMAKE_BUILD_TYPE="Debug"
LLVM_TARGETS_TO_BUILD="X86"


#-DLLVM_ENABLE_PIC="ON" \
#-DLLVM_ENABLE_RTTI="ON" \
#-DBUILD_SHARED_LIBS="ON" \
#-DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE \
#-DCMAKE_INSTALL_PREFIX=$CMAKE_INSTALL_PREFIX \
#-DLLVM_TARGETS_TO_BUILD=$LLVM_TARGETS_TO_BUILD \

#-DLLVM_ENABLE_PIC="ON" \
#-DLLVM_ENABLE_RTTI="ON" \

CXX=${HOST_CXX}
CC=${HOST_CC}

#CXX="/dist/intel/parallel_studio_xe_2017/compilers_and_libraries_2017.2.174/linux/bin/intel64/icpc"
#CC="/dist/intel/parallel_studio_xe_2017/compilers_and_libraries_2017.2.174/linux/bin/intel64/icc"

#    -DCMAKE_CXX_FLAGS="-cxxlib=/opt/crtdc/gcc/4.8.5-4/ -std=c++11" \
#    -DCMAKE_C_FLAGS="-cxxlib=/opt/crtdc/gcc/4.8.5-4/" \

cmake3 -G "Unix Makefiles" \
    -DBUILD_SHARED_LIBS="OFF" \
    -DLLVM_ENABLE_ZLIB="OFF" \
    -DLLVM_ENABLE_TERMINFO="OFF" \
    -DCMAKE_BUILD_TYPE=$CMAKE_BUILD_TYPE \
    -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/llvm \
    -DLLVM_TARGETS_TO_BUILD=$LLVM_TARGETS_TO_BUILD \
    -DCMAKE_CXX_COMPILER=$CXX \
    -DCMAKE_C_COMPILER=$CC \
    -DCMAKE_CXX_FLAGS="-cxxlib=/usr/local/gcc-${GCC_VERSION} -std=c++11" \
    -DCMAKE_C_FLAGS="-cxxlib=/usr/local/gcc-${GCC_VERSION}" \
    ${SRCDIR}/llvm-4.0.0.src


${MAKE}

${MAKE} install

popd
