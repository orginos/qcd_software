. ../setup.sh

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
# CUDA Has some restrictions on GCC versions. 4.0 is OK I think
MPICH_DIR=/usr/local/ofed/mpi/gcc/mvapich-1.0.1

export LD_LIBRARY_PATH=/net/lattice-fs/data/software/opt/gcc-4.9.0/lib:/net/lattice-fs/data/software/opt/gcc-4.9.0/lib64:$MPI/lib:$MPI/lib/shared
export PATH=/net/lattice-fs/data/software/opt/gcc-4.9.0/bin:$PATH


### DIRECTORIES
MPIHOME=${MPICH_DIR}

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install
SCALAR_INSTALLDIR=${TOPDIR}/../scalar/install

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build

### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
PK_MPI_HOME=${MPIHOME}           

### OpenMP
#OMPFLAGS="-fopenmp"
#OMPENABLE="--enable-openmp"
OMPFLAGS=""
OMPENABLE=""

### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}" -O3 -std=c++11  -march=core2 "

PK_CFLAGS=${OMPFLAGS}" -O3  -std=gnu99 -D_REENTRANT -march=core2 -I${PK_MPI_HOME}/include"

##
PK_COMS_LD="-L${MPIHOME}/lib"  
PK_COMS_LIBS="-lmpich -lpthread -libumad -libverbs "
PK_MPICC=mpicc
### Make
MAKE="make -j 8"

### MPI
PK_CC=gcc
PK_CXX=g++
HOST_CC=gcc
HOST_CXX=g++
HOST_CXXFLAGS="-O3"
HOST_CFLAGS="-03"
