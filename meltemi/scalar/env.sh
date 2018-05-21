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


if test "X${MKLROOT}X" == "XX";
then
 MKL_INC=""
 MKL_LINK=""
else
 MKL_INC=" -I${MKLROOT}/include"
 if test "X${OMPFLAGS}X" == "XX";
 then
    # SEQUENTIAL LIBS
    MKL_LINK=" -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_sequential.a -Wl,--end-group -lpthread -lm"
 else
    # Threaded Libs
    MKL_LINK=" -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_intel_thread.a -Wl,--end-group -lpthread -lm"
 fi
fi

echo "MKL INCLUDE FLAGS:" $MKL_INC
echo "MKL LINKL FLAGS:" $MKL_LINK

PAR_STUDIO=/usr/local/intel-2017/parallel_studio_xe_2017.2.050
VTUNE=VTUNE=$PAR_STUDIO/vtune_amplifier_xe_2017
export TBBLIBDIR=$PAR_STUDIO/compilers_and_libraries_2017/linux/tbb/lib/intel64/gcc4.7
export TBBINCDIR=$PAR_STUDIO/compilers_and_libraries_2017/linux/tbb/include
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
#ARCHFLAGS="-xMIC-AVX512 -qopt-report=3 -qopt-report-phase=vec  -restrict"
ARCHFLAGS="-xMIC-AVX512"
export PK_AVX_VERSION="AVX512"

#ARCHFLAGS=" -march=corei7-avx -Drestrict=__restrict__" 
PK_CXXFLAGS=${OMPFLAGS}" -g -O3 -std=c++11 "${ARCHFLAGS}" "
PK_CFLAGS=${OMPFLAGS}" -g -O3 -std=c99 "${ARCHFLAGS}" "
PK_FCFLAGS=${OMPFLAGS}" -O3 -mkl -qopt-report -qopt-report-phase=openmp,vec"${ARCHFLAGS}" "

### Make
MAKE="make -j 40"

### MPI
PK_CC=icc
PK_CXX=icpc
PK_FC=ifort
HOST_CC=icc
HOST_CXX=icpc
HOST_CXXFLAGS="-O3"
HOST_CFLAGS="-03"
#PK_CC="mpicc -cc=icc "
#PK_CXX="mpicxx -CC=icpc "
