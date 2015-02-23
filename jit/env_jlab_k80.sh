##### 
# SET UP ENVIRONMENT
. ../setup.sh


CUDA_INSTALL_PATH=/usr/local/cuda-6.5
MPIHOME=/usr/mpi/gcc/mvapich2-2.0rc1
OMP="no"

# SM=sm_35     # Kepler GK110
# SM=sm_20   # Fermi
# SM=sm_13   # Pre-Fermi, with DP support eg. GTX285
SM=sm_35     # Kepler Gaming

export PATH=/dist/gcc-4.8.2/bin:${CUDA_INSTALL_PATH}/bin:${MPIHOME}/bin:$PATH
export LD_LIBRARY_PATH=/dist/gcc-4.8.2/lib64:/dist/gcc-4.8.2/lib:${CUDA_INSTALL_PATH}/lib64:${CUDA_INSTALL_PATH}/lib:${MPIHOME}/lib:${MPIHOME}/lib64:/usr/lib64:/usr/lib:$LD_LIBRARY_PATH

# The directory containing the build scripts, this script and the src/ tree
TOPDIR=`pwd`

# Install directory
INSTALLDIR=${TOPDIR}/install/${SM}

# Source directory
SRCDIR=${TOPDIR}/../src

# Build directory
BUILDDIR=${TOPDIR}/build


### ENV VARS for CUDA/MPI
# These are used by the configure script to make make.inc
PK_CUDA_HOME=${CUDA_INSTALL_PATH}
PK_MPI_HOME=${MPIHOME}
PK_GPU_ARCH=${SM}

### OpenMP
# Open MP enabled
if [ "x${OMP}x" == "xyesx" ]; 
then 
 OMPFLAGS="-fopenmp -D_REENTRANT "
 OMPENABLE="--enable-openmp"
 INSTALLDIR=${INSTALLDIR}_omp
else
 OMPFLAGS=""
 OMPENABLE=""
fi

if [ ! -d ${INSTALLDIR} ];
then
  mkdir -p ${INSTALLDIR}
fi
### COMPILER FLAGS
PK_CXXFLAGS=${OMPFLAGS}"-O3 -finline-limit=50000 -march=corei7-avx  -fargument-noalias-global -std=c++11"

PK_CFLAGS=${OMPFLAGS}" -O3 -march=corei7-avx -fargument-noalias-global -std=gnu99"

### Make
MAKE="make -j 10"

### MPI
PK_CC=mpicc
PK_CXX=mpicxx
PK_NVCCFLAGS=""
