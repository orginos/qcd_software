. ../../setup.sh

##### 
# SET UP ENVIRONMENT
#
# This should do the following:
#  setup mpicc and mpicxx on your PATH
#  setup nvcc on your PATH
#  setup LD_LIBRARY_PATH for CUDA and MPI 
#  set env var MPIHOME pointing to the MPI installation
#  set env var CUDA_INSTALL_PATH to point to CUDA Install location
#  
#  FOR LLNL at Livermore, and Keeneland this is done through modules
#  The modules below are for Keeneland. If you are not using modules
#  Please manually set the MPIHOME and CUDA_INSTALL_PATH variables
#  If your MPI wrapper is not mpicc/mpicxx you may still need to do some
#  tedious mucking about in the src/quda/make.inc file
#
#export PATH=/dist/gcc-4.9.2/bin:$PATH
#export LD_LIBRARY_PATH=/dist/gcc-4.9.2/lib64:$LD_LIBRARY_PATH

/usr/local/Modules/$MODULE_VERSION/bin/modulecmd bash unload intel/2017
/usr/local/Modules/$MODULE_VERSION/bin/modulecmd bash unload openmpi/1.10.6/intel-hfi

/usr/local/Modules/$MODULE_VERSION/bin/modulecmd bash load gcc/6.3.0
#/usr/local/Modules/$MODULE_VERSION/bin/modulecmd bash load openmpi/1.10.6/gcc-hfi
/usr/local/Modules/$MODULE_VERSION/bin/modulecmd bash load mvapich2/2.2/gcc-hfi 

/usr/local/Modules/$MODULE_VERSION/bin/modulecmd bash list

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install
SCALAR_INSTALLDIR=${TOPDIR}/../scalar/install

# Source directory
SRCDIR=${TOPDIR}/../../src

# Build directory
BUILDDIR=${TOPDIR}/build

TBBLIBDIR="/usr/local/intel-2017/tbb/lib/intel64_lin_mic/"
TBBINCDIR="/usr/local/intel-2017/tbb/include"
MKLROOT="/usr/local/intel-2017/compilers_and_libraries_2017.2.174/linux/mkl"

### OpenMP
#OMPFLAGS="-fopenmp -DUSE_OMP"
#OMPENABLE="--enable-openmp"
#OMPFLAGS=""
#OMPENABLE=""
### OpenMP for INTEL
OMPFLAGS="-fopenmp -D_REENTRANT"
OMPENABLE="--enable-openmp"

#
# ENABLE THis for AVX
ARCHFLAGS="-mavx512f -mavx512cd -mavx512er -mavx512pf  "
export PK_AVX_VERSION="AVX512"

#ARCHFLAGS=" -march=corei7-avx -Drestrict=__restrict__" 
PK_CXXFLAGS=${OMPFLAGS}"  -O3 -finline-functions -fargument-noalias-global -std=c++11 "${ARCHFLAGS}
PK_CFLAGS=${OMPFLAGS}"   -O3  -std=c99 "${ARCHFLAGS}

### Make
MAKE="make -j 40"

### MPI
#PK_CC=icc
#PK_CXX=icpc
HOST_CC=gcc
HOST_CXX=g++
HOST_CXXFLAGS="-O3"
HOST_CFLAGS="-O3"
PK_CC=mpicc 
PK_CXX=mpic++

