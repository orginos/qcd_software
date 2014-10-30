##### 
# SET UP ENVIRONMENT
#


OMP="yes"     # For JIT-ing don't use OpenMP for now
SM=sm_35     # Kepler GK110


# Set Compilers and paths
export PATH=/usr/mpi/gcc/mvapich2-1.8/bin:$PATH
export PATH=/dist/gcc-4.8.2/bin:$PATH
export LD_LIBRARY_PATH=/usr/mpi/gcc/mvapich2-1.8/lib:$LD_LIBRARY_PATH

# CUDA Has some restrictions on GCC versions. 4.0 is OK I think
CUDA_HOME=$CUDATOOLKIT_HOME

### DIRECTORIES
MPIHOME=${MPICH_DIR}
CUDA_INSTALL_PATH=${CUDA_HOME}

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install/

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build

### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
PK_CUDA_HOME=${CUDA_INSTALL_PATH}    # If module sets this, fine. Otherwise do by hand
PK_MPI_HOME=${MPIHOME}               # If module sets this, fine. Otherwise do by hand
PK_GPU_ARCH=${SM}	# GK110 Arch

### OpenMP
# OpenMP is enabled
if [ "x${OMP}x" == "xyesx" ]; 
then 
 OMPFLAGS="-fopenmp -D_REENTRANT "
 OMPENABLE="--enable-openmp"
 INSTALLDIR=${INSTALLDIR}_omp
else
 OMPFLAGS=""
 OMPENABLE=""
fi
if [ ! -d ${INSTALLDIR} ];
then
  mkdir -p ${INSTALLDIR}
fi

### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}" -O2 -std=c++0x -march=core2"

PK_CFLAGS=${OMPFLAGS}" -O2 -march=core2 -std=gnu99"

### Make
MAKE="make -j 10"

### MPI
PK_CC=mpicc
PK_CXX=mpicxx
HOST_CC=gcc
HOST_CXX=g++
HOST_CXXFLAGS="-O2"
HOST_CFLAGS="-02"
