
. ../setup.sh

##### 
# SET UP ENVIRONMENT
# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`
#export PATH=/dist/gcc-4.8.2/bin:$PATH
#export LD_LIBRARY_PATH=/dist/gcc-4.8.2/lib64:/dist/gcc-4.8.2/lib:$LD_LIBRARY_PATH

# Install directory
#INSTALLDIR=${TOPDIR}/install
INSTALLDIR=/usr/local/scidac

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build


### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc

### OpenMP
##OMPFLAGS="-fopenmp"
##OMPENABLE="--enable-openmp"
#no openMP
OMPFLAGS=""
OMPENABLE=""

### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}" -O3 -std=c++11  -funroll-loops   -ffast-math  -mtune=native -march=native  -fstrict-aliasing  -msse2 -msse3"

PK_CFLAGS=${OMPFLAGS}" -O3 -march=native -mtune=native -funroll-loops  -ffast-math -fstrict-aliasing  -std=gnu99 -msse2 -msse3"

### Make
MAKE="make -j 16"

### MPI
PK_CC=mpicc
PK_CXX=mpicxx

PK_F77=gfortran
PK_F77_FLAGS="-g -O3"

