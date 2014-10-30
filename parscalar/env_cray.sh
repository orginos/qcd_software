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
. /opt/modules/default/init/bash
module unload PrgEnv-cray
module unload PrgEnv-pgi
module load PrgEnv-gnu
module unload gcc
module load gcc/4.6.3
module unload cudatoolkit
module load cudatoolkit

# CUDA Has some restrictions on GCC versions. 4.0 is OK I think
module list
CUDA_HOME=$CUDATOOLKIT_HOME

### DIRECTORIES
MPIHOME=${MPICH_DIR}
CUDA_INSTALL_PATH=${CUDA_HOME}
#export PATH=${CUDA_INSTALL_PATH}/bin:${MPIHOME}/bin:$PATH
#export LD_LIBRARY_PATH=${CUDA_INSTALL_PATH}/lib64:${CUDA_INSTALL_PATH}/lib:${MPIHOME}/lib64:${MPIHOME}/lib:${LD_LIBRARY_PATH}

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install/${SM}

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build
SM=sm_35     # Kepler GK110


### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
PK_CUDA_HOME=${CUDA_INSTALL_PATH}    # At LLNL Loading the module sets this. Otherwise do by hand
PK_MPI_HOME=${MPIHOME}               # At LLNL Loading the module sets this. Otherwise do by hand
PK_GPU_ARCH=${SM}	# GK110 Arch

### OpenMP
OMPFLAGS="-fopenmp"
OMPENABLE="--enable-openmp"
#OMPFLAGS=""
#OMPENABLE=""

### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}" -O3 -std=c++0x -march=bdver1 -mprefer-avx128"

PK_CFLAGS=${OMPFLAGS}" -O3 -march=bdver1 -mprefer-avx128 -std=gnu99"

### Make
MAKE="make -j 10"

### MPI
PK_CC=cc
PK_CXX=CC
HOST_CC=gcc
HOST_CXX=g++
HOST_CXXFLAGS="-O3"
HOST_CFLAGS="-03"
