#!/bin/bash
#
#################
# BUILD QUDA
#################
source env.sh

QMPHOME=${INSTALLDIR}/qmp

pushd  ${BUILDDIR}
if [ -d build_quda_qdp_double ]; 
then 
 rm -rf ./build_quda_qdp_double
fi

cp -r ${SRCDIR}/quda ./build_quda_qdp_double

pushd ./build_quda_qdp_double
./configure --with-mpi=${PK_MPI_HOME} \
	--with-cuda=${PK_CUDA_HOME} \
	--enable-gpu-arch=${PK_GPU_ARCH} \
        --enable-multi-gpu \
	--enable-wilson-dirac \
	--enable-clover-dirac \
        --disable-domain-wall-dirac \
        --disable-staggered-dirac \
        --disable-twisted-mass-dirac \
        --disable-ndeg-twisted-mass-dirac \
        --disable-staggered-fatlink \
        --disable-gauge-force \
        --disable-hisq-force \
        --disable-milc-interface \
        --disable-cps-interface \
	--disable-numa-affinity \
	--enable-qdp-jit \
	--enable-qdpjit-interface \
	--with-qdp=${INSTALLDIR}/qdp++-double \
	CC=${PK_CC} CXX=${PK_CXX} \
	--host=x86_64-unknown-linux \
	--build=x86_64-suse-linux \
	--with-qmp=${INSTALLDIR}/qmp
make clean
make
popd

rm -rf ${INSTALLDIR}/quda_qdp_double
cp -r ./build_quda_qdp_double ${INSTALLDIR}/quda_qdp_double

popd
