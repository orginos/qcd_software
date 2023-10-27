#!/bin/bash

##### 
# SET UP ENVIRONMENT
#
source /usr/local/Modules/default/init/bash

module load isa/knl
module load intel/2019
module load intel/mpi-2019
module load python/3.5.3/intel
module load cmake/3.9.1


TOPDIR=`pwd`
INSTALLDIR=${TOPDIR}/install

# Source directory
SRCDIR=${TOPDIR}/../../src

# Build directory
BUILDDIR=${TOPDIR}/build


### OpenMP
#OMPFLAGS="-fopenmp "
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
    MKL_LINK=" -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_sequential.a -Wl,--end-group -lpthread -lm"
 else
    # Threaded Libs
    MKL_LINK=" -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_intel_thread.a -Wl,--end-group -lpthread -lm"
 fi
fi

echo "MKL INCLUDE FLAGS:" $MKL_INC
echo "MKL LINKL FLAGS:" $MKL_LINK

export PK_QPHIX_ISA="avx512"
export PK_KOKKOS_HOST_ARCH="KNL"
#ARCHFLAGS=" -march=knl "
ARCHFLAGS=" -xMIC-AVX512 "

#PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 -stdlib=libc++ -Drestrict=__restrict__ "${ARCHFLAGS}
PK_CXXFLAGS=${OMPFLAGS}"-g -O3 -std=c++14 "${ARCHFLAGS}
PK_CFLAGS=${OMPFLAGS}"-g -O3 -std=c99 "${ARCHFLAGS}" "

### Make
PK_TARGET_JN="10"
MAKE="make -j ${PK_TARGET_JN}" 

# Compilers for compiling package (passed as CC to ./configure throghout) 
PK_CC="icc"
PK_CXX="icpc"
PK_FC=ifort

PK_HOST_CXX=icpc
PK_HOST_CXXFLAGS="-g -O3 -std=c++11 "
