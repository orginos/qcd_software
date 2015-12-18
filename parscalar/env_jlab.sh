. /usr/share/Modules/init/bash
##### 
# SET UP ENVIRONMENT
module purge
module load gcc-4.6.3
module load mvapich2-1.8
module list


### DIRECTORIES
MPIHOME=/usr/mpi/gcc/mvapich2-1.8
export PATH=${MPIHOME}/bin:$PATH
export LD_LIBRARY_PATH=${MPIHOME}/lib64:$LD_LIBRARY_PATH

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install

# Source directory
SRCDIR=${TOPDIR}/src

# Build directory
BUILDDIR=${TOPDIR}/build


### ENV VARS for CUDA/MPI
PK_MPI_HOME=${MPIHOME}               # At LLNL Loading the module sets this. Otherwise do by hand

### OpenMP
OMPFLAGS="-fopenmp"
OMPENABLE="--enable-openmp"

### COMPILER FLAGS
#PK_CXXFLAGS=${OMPFLAGS}" -O3 -finline-limit=50000 -march=core2 -fargument-noalias-global "
PK_CXXFLAGS=${OMPFLAGS}" -O3 -finline-limit=50000 -march=corei7-avx -mprefer-avx128  -fargument-noalias-global  -std=c++11"

#PK_CFLAGS=${OMPFLAGS}" -O3 -march=core2 -fargument-noalias-global -std=c99"
PK_CFLAGS=${OMPFLAGS}" -O3 -march=corei7-avx -mprefer-avx128 -fargument-noalias-global"


### Make
MAKE="make -j 10"

### MPI
PK_CC=mpicc
PK_CXX=mpicxx
#PK_CC=gcc
#PK_CXX=g++
