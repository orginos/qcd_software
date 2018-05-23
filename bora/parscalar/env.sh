. ../../setup.sh

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
#export PATH=/dist/gcc-4.9.2/bin:$PATH
#export LD_LIBRARY_PATH=/dist/gcc-4.9.2/lib64:$LD_LIBRARY_PATH

#source /dist/intel/parallel_studio_xe_2016.3.067/psxevars.sh intel64

### DIRECTORIES
#MPIHOME=${MPICH_DIR}
modulecmd sh  load isa
modulecmd sh  load intel
modulecmd sh  load mpi
modulecmd sh list

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install
SCALAR_INSTALLDIR=${TOPDIR}/../scalar/install

# Source directory
SRCDIR=${TOPDIR}/../../src

# Build directory
BUILDDIR=${TOPDIR}/build

### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
#PK_MPI_HOME=${MPIHOME}               # At LLNL Loading the module sets this. Otherwise do by hand
PAR_STUDIO=/usr/local/intel-2017/parallel_studio_xe_2017.0.035
#PAR_STUDIO=/usr/local/intel-2016/parallel_studio_xe_2016.4.072
VTUNE=$PAR_STUDIO/vtune_amplifier_xe
export TBBLIBDIR=$PAR_STUDIO/linux/tbb/lib/intel64/gcc4.7
export TBBINCDIR=$PAR_STUDIO/linux/tbb/include
export VTUNEINCDIR=$VTUNE/include
export VTUNELIBDIR=$VTUNE/lib64
source  $PAR_STUDIO/psxevars.sh intel64

### OpenMP
#OMPFLAGS="-fopenmp -DUSE_OMP"
#OMPENABLE="--enable-openmp"
#OMPFLAGS=""
#OMPENABLE=""
### OpenMP for INTEL
OMPFLAGS="-qopenmp -D_REENTRANT"
OMPENABLE="--enable-openmp"

#
# ENABLE THis for AVX
ARCHFLAGS="-xCORE-AVX2   -restrict"
export PK_AVX_VERSION="AVX2"

#ARCHFLAGS=" -march=corei7-avx -Drestrict=__restrict__" 
PK_CXXFLAGS=${OMPFLAGS}"  -O3 -finline-functions -fma -align -fno-alias -std=c++11 -Wl,-zmuldefs "${ARCHFLAGS}
PK_CFLAGS=${OMPFLAGS}"   -O3 -fma -align -fno-alias -std=c99 "${ARCHFLAGS}

### Make
MAKE="make -j 40"

### MPI
#PK_CC=icc
#PK_CXX=icpc
HOST_CC=icc
HOST_CXX=icpc
HOST_CXXFLAGS="-O3"
HOST_CFLAGS="-O3"
PK_CC=mpiicc 
PK_CXX=mpiicpc

