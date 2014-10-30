##### 
# SET UP ENVIRONMENT
# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`
export PATH=/dist/gcc-4.8.2/bin:$PATH
export LD_LIBRARY_PATH=/dist/gcc-4.8.2/lib64:/dist/gcc-4.8.2/lib:$LD_LIBRARY_PATH

# Install directory
INSTALLDIR=${TOPDIR}/install

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build


### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc

### OpenMP
OMPFLAGS="-fopenmp"
OMPENABLE="--enable-openmp"

### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}" -O3 -std=c++11  -finline-limit=50000 -march=corei7-avx  -fargument-noalias-global"

PK_CFLAGS=${OMPFLAGS}" -O3 -march=corei7-avx -fargument-noalias-global -std=gnu99"

### Make
MAKE="make -j 10"

### MPI
PK_CC=gcc
PK_CXX=g++
