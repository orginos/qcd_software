#!/bin/bash
#
#################
# BUILD QUDA
#################
source env.sh

QMPHOME=${INSTALLDIR}/qmp

pushd  ${BUILDDIR}
if [ -d build_quda ]; 
then 
 rm -rf ./build_quda
fi

cp -r ${SRCDIR}/quda ./build_quda

# Clean the tmp-space
rm -rf /scratch/bjoo/tmp/*

pushd ./build_quda
./configure --with-mpi=${PK_MPI_HOME} \
	--with-cuda=${PK_CUDA_HOME} \
	--enable-gpu-arch=${PK_GPU_ARCH} \
        --enable-multi-gpu \
        --enable-wilson-dirac \
        --enable-clover-dirac \
        --enable-domain-wall-dirac \
        --disable-staggered-dirac \
        --disable-twisted-mass-dirac \
        --disable-ndeg-twisted-mass-dirac \
        --disable-staggered-fatlink \
        --disable-gauge-force \
        --disable-hisq-force \
        --disable-milc-interface \
        --disable-cps-interface \
        --disable-numa-affinity \
	CC=${PK_CC} CXX=${PK_CXX} \
	--host=x86_64-unknown-linux \
	--build=x86_64-suse-linux \
	--with-qmp=${INSTALLDIR}/qmp ${PK_NVCCFLAGS}

make clean
make
popd

rm -rf ${INSTALLDIR}/quda
cp -r ./build_quda ${INSTALLDIR}/quda

popd
