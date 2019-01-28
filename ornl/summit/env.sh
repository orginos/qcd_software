##### 
# SET UP ENVIRONMENT

module load cuda
export PK_CUDA_HOME=${CUDA_DIR}
module load gcc/6.4.0
module load spectrum-mpi
export PK_MPI_HOME=${MPI_ROOT}
module load cmake
module list 

# having a problem with mpi module
SM=sm_70     # Kepler Gaming
OMP="yes"


# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install/${SM}


if [ "x${OMP}x" == "xyesx" ];
then
 INSTALLDIR=${INSTALLDIR}_omp
fi

#Eigen Install Directory
EIGEN_INSTALL_DIR=${HOME}/install/eigen3
export EIGEN_INCLUDE_DIR=${EIGEN_INSTALL_DIR}/include/eigen3
# LLVM Install Directory
LLVM_INSTALL_DIR=${HOME}/install/llvm6-trunk-summit
export PATH=${LLVM_INSTALL_DIR}/bin:${PATH}
export LD_LIBRARY_PATH=${LLVM_INSTALL_DIR}/lib:${LD_LIBRARY_PATH}
export GCC_HOME=/sw/summit/gcc/6.4.0
export LD_LIBRARY_PATH=${GCC_HOME}/lib64:${GCC_HOME}/lib:${LD_LIBRARY_PATH}
# Source directory
SRCDIR=${TOPDIR}/../../src

# Build directory
BUILDDIR=${TOPDIR}/build


### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
export LD_LIBRARY_PATH=${PK_CUDA_HOME}/nvvm/lib:${LD_LIBRARY_PATH}
PK_GPU_ARCH=${SM}

### OpenMP
# Open MP enabled
if [ "x${OMP}x" == "xyesx" ]; 
then 
 OMPFLAGS="-fopenmp -D_REENTRANT "
 OMPENABLE="--enable-openmp"
else
 OMPFLAGS=""
 OMPENABLE=""
fi

if [ ! -d ${INSTALLDIR} ];
then
  mkdir -p ${INSTALLDIR}
fi
### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}" -g -O3 -std=c++11 "

PK_CFLAGS=${OMPFLAGS}" -g -O3 -std=gnu99"

### Make
MAKE="make -j 10"

### MPI
PK_CC=mpicc
PK_CXX=mpicxx
QDPJIT_HOST_ARCH="PowerPC;NVPTX"
PK_LLVM_CXX=g++
PK_LLVM_CC=gcc
PK_LLVM_CFLAGS="-O3 -std=c99"
PK_LLVM_CXXFLAGS="-O3 -std=c++11"
JITARCHS="${QDPJIT_HOST_ARCH},nvptx"
