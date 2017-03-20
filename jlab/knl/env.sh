. ../../setup.sh
##### 
# SET UP ENVIRONMENT
#
# Setup script for GCC
#
# Source whatever it is you need to set up your compiler here.
# Change this to use your compiler.

#source /dist/intel/parallel_studio_xe_2016.3.067/psxevars.sh intel64
PAR_STUDIO=/dist/intel/parallel_studio_xe_2017/parallel_studio_xe_2017.2.050/
VTUNE=$PAR_STUDIO/vtune_amplifier_xe_2017
export TBBLIBDIR=$PAR_STUDIO/linux/tbb/lib/intel64/gcc4.7
export TBBINCDIR=$PAR_STUDIO/linux/tbb/include
export VTUNEINCDIR=$VTUNE/include
export VTUNELIBDIR=$VTUNE/lib64
source  $PAR_STUDIO/psxevars.sh intel64
mpsvars.sh --vtune

export GCC_VERSION="6.2.0"
export PATH=/dist/gcc-${GCC_VERSION}/bin:/dist/binutils-2.27/bin:/apps/python/python-2.7.1/bin:$PATH
export LD_LIBRARY_PATH=/dist/gcc-${GCC_VERSION}/lib64:/dist/gcc-${GCC_VERSION}/lib:/dist/binutils-2.27/lib64:/dist/binutils-2.27/lib:/apps/python/python-2.7.1/lib:/apps/python/python-2.7.1/lib/python2.7:/usr/lib64:/usr/lib:$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/bjoo/install/llvm-trunk-intel/lib:$LD_LIBRARY_PATH
TOPDIR=`pwd`
INSTALLDIR=${TOPDIR}/install

# Source directory
SRCDIR=${TOPDIR}/../../src

#scalar instalation directory
SCALAR_INSTALLDIR=${TOPDIR}/../scalar-knl/install

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



ARCHFLAGS="-xMIC-AVX512"
export PK_AVX_VERSION="AVX512"
#ARCHFLAGS="-xCORE-AVX2"

#PK_CXXFLAGS=${OMPFLAGS}" -g -O3 -std=c++11 "${ARCHFLAGS}" -cxxlib=/dist/gcc-5.3.0 "
#PK_CFLAGS=${OMPFLAGS}" -g -O3 -std=c99 "${ARCHFLAGS}" -cxxlib=/dist/gcc-5.3.0 "

PK_CXXFLAGS=${OMPFLAGS}" -g -O3 -std=c++11 "${ARCHFLAGS}" "
PK_CFLAGS=${OMPFLAGS}" -g -O3 -std=c99 "${ARCHFLAGS}" "

### Make
MAKE="make -j 24"

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
