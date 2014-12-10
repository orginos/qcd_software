##### 
# SET UP ENVIRONMENT
#
# Setup script for GCC
#
# Source whatever it is you need to set up your compiler here.
# Change this to use your compiler.
. /opt/modules/default/init/bash
module unload PrgEnv-cray
module unload PrgEnv-intel
module unload PrgEnv-pgi
module unload PrgEnv-gnu
module unload darshan
module load PrgEnv-intel
module load perftools
module list


TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build


### OpenMP
OMPFLAGS="-openmp -D_REENTRANT"
OMPENABLE="--enable-openmp"

# ENABLE THis for AVX
# This archflag is for ICC v15
#ARCHFLAGS="-xAVX -qopt-report=3 -qopt-report-phase=vec  -restrict"

#ARCHFLAGS="-xAVX -opt-report -vec-report -restrict"
ARCHFLAGS="-xAVX -restrict" 

PK_CXXFLAGS=${OMPFLAGS}" -g -O2 -finline-functions -fno-alias -std=c++11 "${ARCHFLAGS}

PK_CFLAGS=${OMPFLAGS}" -g  -O2 -fno-alias -std=c99 "${ARCHFLAGS}

### Make
MAKE="make -j 8"

# Compilers for compiling package (passed as CC to ./configure throghout) 

# Cray stuff
PK_CC=cc
PK_CXX=CC
