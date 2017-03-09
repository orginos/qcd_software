#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh


pushd ${BUILDDIR}

if [ -d ./build_nplqcd ]; 
then 
  rm -rf ./build_nplqcd
fi

mkdir  ./build_nplqcd
cd ./build_nplqcd

CHROMA_DIR=${INSTALLDIR}/chroma

cmake3 -DCHROMA_PREFIX_PATH=${CHROMA_DIR} -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/nplqcd -DCMAKE_CXX_COMPILER=${PK_CXX} -DBUILD_KNL_QQQ=ON -DLAPACK_LD="-L${MKLROOT}/lib/intel64" -DLAPACK_LIBS="-Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_ilp64.a ${MKLROOT}/lib/intel64/libmkl_sequential.a ${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group"  ${SRCDIR}/nplqcd



${MAKE}
${MAKE} install

popd
