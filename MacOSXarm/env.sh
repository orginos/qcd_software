
. ../setup.sh

##### 
# SET UP ENVIRONMENT
# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
#INSTALLDIR=${TOPDIR}/install
INSTALLDIR=/opt/scidac

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
#-std=c++20
PK_CXXFLAGS=${OMPFLAGS}" -std=c++11 -O3 -funroll-loops   -ffast-math  -fstrict-aliasing  "

PK_CFLAGS=${OMPFLAGS}" -O3  -funroll-loops  -ffast-math -fstrict-aliasing  -std=gnu99 "

### Make
MAKE="make -j 8"

### MPI
PK_CC=gcc
PK_CXX=g++

PK_F77=gfortran
PK_F77_FLAGS="-g -O3"

