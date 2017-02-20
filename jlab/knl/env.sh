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
source /dist/intel/parallel_studio_xe_2016.3.067/psxevars.sh intel64

### DIRECTORIES
#MPIHOME=${MPICH_DIR}

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install
SCALAR_INSTALLDIR=${TOPDIR}/../scalar-knl/install

# Source directory
SRCDIR=${TOPDIR}/../../src

# Build directory
BUILDDIR=${TOPDIR}/build

### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
#PK_MPI_HOME=${MPIHOME}               # At LLNL Loading the module sets this. Otherwise do by hand

export TBBLIBDIR=/dist/intel/parallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/tbb/lib/intel64/gcc4.4
export TBBINCDIR=/dist/intel/parallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/tbb/include
export VTUNEINCDIR=/dist/intel/vtune_amplifier_xe_2016.4.0.470476/include
export VTUNELIBDIR=/dist/intel/vtune_amplifier_xe_2016.4.0.470476/lib64

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
ARCHFLAGS="-xAVX -qopt-report=3 -qopt-report-phase=vec  -restrict"

#ARCHFLAGS=" -march=corei7-avx -Drestrict=__restrict__" 
PK_CXXFLAGS=${OMPFLAGS}"  -O3 -finline-functions -fno-alias -std=c++11 "${ARCHFLAGS}
PK_CFLAGS=${OMPFLAGS}"   -O3 -fno-alias -std=c99 "${ARCHFLAGS}

### Make
MAKE="make -j 48"

### MPI
#PK_CC=icc
#PK_CXX=icpc
HOST_CC=icc
HOST_CXX=icpc
HOST_CXXFLAGS="-O3"
HOST_CFLAGS="-O3"
PK_CC=mpiicc 
PK_CXX=mpiicpc
