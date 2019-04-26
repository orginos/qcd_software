. ../../../setup.sh

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
#module unload PrgEnv-intel
#module load PrgEnv-gnu
module load cmake
# CUDA Has some restrictions on GCC versions. 4.0 is OK I think
module list

### DIRECTORIES
MPIHOME=${MPICH_DIR}

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install
SCALAR_INSTALLDIR=${TOPDIR}/../scalar/install/

# Source directory
SRCDIR=${TOPDIR}/../../../src

# Build directory
BUILDDIR=${TOPDIR}/build

### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
PK_MPI_HOME=${MPIHOME}               # At LLNL Loading the module sets this. Otherwise do by hand

### OpenMP
#OMPFLAGS="-fopenmp"
#OMPENABLE="--enable-openmp"
OMPFLAGS=""
OMPENABLE=""

#ARCHFLAGS="-xAVX -restrict"
ARCHFLAGS="-xMIC-AVX512 -restrict"

### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}" -O3 -std=c++14 -finline-functions -fno-alias "${ARCHFLAGS}
PK_CFLAGS=${OMPFLAGS}" -O3 -fno-alias -std=gnu99 "${ARCHFLAGS}

### Make
MAKE="make -j 20"

### MPI
PK_CC=cc
PK_CXX=CC
HOST_CC=gcc
HOST_CXX=g++
HOST_CXXFLAGS="-O3"
HOST_CFLAGS="-03"
