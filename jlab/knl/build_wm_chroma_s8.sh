#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh


pushd ${BUILDDIR}

if [ -d ./build_wm_chroma ]; 
then 
  rm -rf ./build_wm_chroma
fi

mkdir  ./build_wm_chroma
cd ./build_wm_chroma

CHROMA_DIR=${INSTALLDIR}/chroma_s8

cmake -DCHROMA_PREFIX_PATH=${CHROMA_DIR} -DCMAKE_INSTALL_PREFIX=${INSTALLDIR}/wm_chroma_s8 -DCMAKE_CXX_COMPILER=${PK_CXX}  -DLAPACK_LD="-L${MKLROOT}/lib/intel64" -DLAPACK_LIBS="-Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_intel_ilp64.a ${MKLROOT}/lib/intel64/libmkl_sequential.a ${MKLROOT}/lib/intel64/libmkl_core.a -Wl,--end-group" ${SRCDIR}/wm_chroma

${MAKE}
${MAKE} install

popd
