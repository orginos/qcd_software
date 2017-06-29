. ../../setup.sh
##### 
# SET UP ENVIRONMENT
#
# Setup script for GCC
#
# Source whatever it is you need to set up your compiler here.
# Change this to use your compiler.


# These are used by the configure script to make make.inc                                                       
#PK_MPI_HOME=${MPIHOME}               # At LLNL Loading the module sets this. Otherwise do by hand             
PAR_STUDIO=/usr/local/intel-2017/parallel_studio_xe_2017.2.050
#PAR_STUDIO=/usr/local/intel-2016/parallel_studio_xe_2016.4.072                                                  
VTUNE=$PAR_STUDIO/vtune_amplifier_xe
export TBBLIBDIR=$PAR_STUDIO/linux/tbb/lib/intel64/gcc4.7
export TBBINCDIR=$PAR_STUDIO/linux/tbb/include
export VTUNEINCDIR=$VTUNE/include
export VTUNELIBDIR=$VTUNE/lib64
source  $PAR_STUDIO/psxevars.sh intel64
mpsvars.sh --vtune

export GCC_VERSION="6.3.0"
export PATH=/usr/local/gcc-${GCC_VERSION}/bin:/usr/local/binutils-2.27/bin:/apps/python/python-2.7.1/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/gcc-${GCC_VERSION}/lib64:/usr/local/gcc-${GCC_VERSION}/lib:/usr/lib:$LD_LIBRARY_PATH

TOPDIR=`pwd`
INSTALLDIR=${TOPDIR}/install

export LD_LIBRARY_PATH=$INSTALLDIR/llvm/lib:$LD_LIBRARY_PATH

# Source directory
SRCDIR=${TOPDIR}/../../src

# Build directory
BUILDDIR=${TOPDIR}/build


### OpenMP
OMPFLAGS="-qopenmp "
OMPENABLE="--enable-openmp"

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

export TBBLIBDIR=$PAR_STUDIO/compilers_and_libraries_2017/linux/tbb/lib/intel64/gcc4.7
export TBBINCDIR=$PAR_STUDIO/compilers_and_libraries_2017/linux/tbb/include
export VTUNEINCDIR=/usr/local/intel-2017/vtune_amplifier_xe_2017.2.0.499904/include/intel64/
export VTUNELIBDIR=$PAR_STUDIO/vtune_amplifier_xe_2017/lib64

#export TBBLIBDIR=/dist/intel/parallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/tbb/lib/intel64/gcc4.4
#export TBBINCDIR=/dist/intel/parallel_studio_xe_2016.3.067/compilers_and_libraries_2016/linux/tbb/include
#export VTUNEINCDIR=/dist/intel/vtune_amplifier_xe_2016.4.0.470476/include
#export VTUNELIBDIR=/dist/intel/vtune_amplifier_xe_2016.4.0.470476/lib64


ARCHFLAGS="-xMIC-AVX512"
export PK_AVX_VERSION="AVX512"
#ARCHFLAGS="-xCORE-AVX2"

#PK_CXXFLAGS=${OMPFLAGS}" -g -O3 -std=c++11 "${ARCHFLAGS}" -cxxlib=/dist/gcc-5.3.0 "
#PK_CFLAGS=${OMPFLAGS}" -g -O3 -std=c99 "${ARCHFLAGS}" -cxxlib=/dist/gcc-5.3.0 "

PK_CXXFLAGS=${OMPFLAGS}" -g -O3 -std=c++11 "${ARCHFLAGS}" "
PK_CFLAGS=${OMPFLAGS}" -g -O3 -std=c99 "${ARCHFLAGS}" "

### Make
MAKE="make -j 10"

# Compilers for compiling package (passed as CC to ./configure throghout) 
#PK_CC=icc
#PK_CXX=icpc
PK_CC=mpiicc
PK_CXX=mpiicpc
#GNU Wrappers
#PK_CC=mpicc
#PK_CXX=mpicxx
#PK_CC="mpicc -cc=icc "
#PK_CXX="mpicxx -CC=icpc "
