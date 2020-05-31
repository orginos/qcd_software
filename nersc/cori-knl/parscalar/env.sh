#. ../setup.sh
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
module unload craype-haswell
module load PrgEnv-intel
#defaults are fine
#module unload intel
#module load intel/19.0.0.117
module load craype-mic-knl
#`module load craype-hugepages2M

module load python3
#module load cmake/3.8.2

module list


TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install

# Source directory
SRCDIR=${TOPDIR}/../../../src

# Build directory
BUILDDIR=${TOPDIR}/build


### OpenMP
OMPFLAGS="-openmp -D_REENTRANT"
OMPENABLE="--enable-openmp"

# ENABLE THis for AVX
# This archflag is for ICC v15
#ARCHFLAGS="-xAVX -qopt-report=3 -qopt-report-phase=vec  -restrict"

#ARCHFLAGS="-xAVX -opt-report -vec-report -restrict"

export PK_QPHIX_ISA="avx512"
export PK_TARGET_JN="10"
export PK_KOKKOS_HOST_ARCH="KNL
"

MKL_INC=""
MKL_LINL=""

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

ARCHFLAGS="-xMIC-AVX512 -restrict" 

PK_CXXFLAGS=${OMPFLAGS}"-dynamic -g -O3 -finline-functions -fno-alias -std=c++11 "${ARCHFLAGS}

PK_CFLAGS=${OMPFLAGS}" -g  -O3 -fno-alias -std=c99 "${ARCHFLAGS}

### Make
MAKE="make -j ${PK_TARGET_JN}"

# Compilers for compiling package (passed as CC to ./configure throghout) 

# Cray stuff
PK_CC=cc
PK_CXX=CC
PK_HOST_CXX=icpc
PK_HOST_CXXFLAGS="-g -O3 -std=c++11 "

