##### 
# SET UP ENVIRONMENT
#
# Setup script for GCC
#
# Source whatever it is you need to set up your compiler here.
# Change this to use your compiler.
source /opt/intel/impi/4.1.1.036/intel64/bin/mpivars.sh
source /opt/intel/composer_xe_2013_sp1.1.106/bin/compilervars.sh intel64

#source /opt/intel/impi_5.0.1/bin64/mpivars.sh
#source /opt/intel/composer_xe_2015.0.090/bin/compilervars.sh intel64

# MVAPICH SETUP FOR HOST
#MPIHOME=/usr/mpi/gcc/mvapich2-1.8
#export PATH=${MPIHOME}/bin:$PATH


# Compiler setup -- YOU MAY NEED TO CHANGE THIS
#source /opt/intel/composerxe/bin/compilervars.sh intel64
#
# Standard default path is here
# source /opt/intel/composerxe/bin/compilervars.sh intel64


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

### COMPILER FLAGS
# For ICC
#ARCHFLAGS="-g -xSSE4.2 -restrict"

#
# ENABLE THis for AVX
#ARCHFLAGS="-xAVX -vec-report -restrict"

# Enable this for MIC
ARCHFLAGS="-mmic -vec-report -restrict -mGLOB_default_function_attrs=\"use_gather_scatter_hint=off\""
#ARCHFLAGS="-mmic -vec-report -restrict "
PK_CXXFLAGS=${OMPFLAGS}" -g -O2 -finline-functions -fno-alias -std=c++0x "${ARCHFLAGS}

PK_CFLAGS=${OMPFLAGS}" -g  -O2 -fno-alias -std=c99 "${ARCHFLAGS}

### Make
MAKE="make -j 8"

# Compilers for compiling package (passed as CC to ./configure throghout) 
#PK_CC=icc
#PK_CXX=icpc
PK_CC=mpiicc
PK_CXX=mpiicpc
#PK_CC="mpicc -cc=icc "
#PK_CXX="mpicxx -CC=icpc "
