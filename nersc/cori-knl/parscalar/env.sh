##### 
# SET UP ENVIRONMENT
#
# Setup script for GCC
#
# Source whatever it is you need to set up your compiler here.
# Change this to use your compiler.

module unload craype-haswell
module load craype-hugepages2M
module load gcc/6.3.0
module load PrgEnv-intel
module unload intel
module load intel/16.0.3.210
module load craype-mic-knl
module unload cmake
module load cmake/3.8.2
module load python/3.5-anaconda
module list
source activate my_jinja_env

export LD_LIBRARY_PATH=/opt/gcc/6.3.0/snos/lib64:${LD_LIBRARY_PATH}
TOPDIR=`pwd`
LLVM_INSTALL_DIR=${HOME}/install/llvm-4.0.0

INSTALLDIR=${TOPDIR}/install

# LLVM Install location for linking
export LD_LIBRARY_PATH=${LLVM_INSTALL_DIR}/lib:${LD_LIBRARY_PATH}

export PK_PYTHON_EXE=${CONDA_PREFIX}/bin/python3
export PK_PYTHON_LIB=${CONDA_PREFIX}/lib
export PK_PYTHON_INC=${CONDA_PREFIX}/include
# Source directory
SRCDIR=${TOPDIR}/../../../src

# Build directory
BUILDDIR=${TOPDIR}/build


### OpenMP
OMPFLAGS="-qopenmp "
OMPENABLE="--enable-openmp"

if test "X${MKLROOT}X" == "XX";
then
 MKL_INC=""
 MKL_LINK=""
else
 MKL_INC=" -I${MKLROOT}/include"
 if test "X${OMPFLAGS}X" == "XX";
 then
    MKL_LINK=" -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_sequential.a -Wl,--end-group -lpthread -lm"
 else
    # Threaded Libs
    MKL_LINK=" -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_intel_thread.a -Wl,--end-group -lpthread -lm"
 fi
fi

echo "MKL INCLUDE FLAGS:" $MKL_INC
echo "MKL LINKL FLAGS:" $MKL_LINK

export TBBLIBDIR=/opt/intel/compilers_and_libraries_2016.3.210/linux/tbb/lib/intel64/gcc4.4
export TBBINCDIR=/opt/intel/compilers_and_libraries_2016.3.210/linux/tbb/include/

export LD_LIBRARY_PATH=${TBBLIBDIR}:${LD_LIBRARY_PATH}

export PK_QPHIX_ISA="avx512"
ARCHFLAGS="-xMIC-AVX512 -restrict -qoverride-limits"

PK_CXXFLAGS=${OMPFLAGS}" -g -O3 -std=c++11 "${ARCHFLAGS}" -dynamic "
PK_CFLAGS=${OMPFLAGS}" -g -O3 -std=c99 "${ARCHFLAGS}" -dynamic  "

### Make
export PK_TARGET_JN="8"
export MAKE="make -j ${PK_TARGET_JN}" 

# Compilers for compiling package (passed as CC to ./configure throghout) 
# Cray Wrapper
PK_CC=cc
# Cray Wrapper
PK_CXX=CC
PK_HOST_CXX=g++
PK_HOST_CC=gcc
PK_HOST_CXXFLAGS="-g -O3 -std=c++11"
PK_HOST_CFLAGS="-g -O3 -std=c99"
PK_LLVM_CXX=${PK_HOST_CXX}
PK_LLVM_CC=${PK_HOST_CC}
PK_LLVM_CFLAGS="${PK_HOST_CFLAGS}"
PK_LLVM_CXXFLAGS="${PK_HOST_CXXFLAGS}"
QDPJIT_HOST_ARCH="X86"

#GNU Wrappers
#PK_CC=mpicc
#PK_CXX=mpicxx
#PK_CC="mpicc -cc=icc "
#PK_CXX="mpicxx -CC=icpc "
