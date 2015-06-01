#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
#autoreconf -f -i 
automake; autoconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma-mg ]; 
then 
  rm -rf ./build_chroma-mg
fi

mkdir  ./build_chroma-mg
cd ./build_chroma-scalar


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma/scalar-mg \
	--with-qdp=${INSTALLDIR}/qdp++/scalar \
        --enable-cpp-wilson-dslash --enable-sse2 --enable-sse3 ${OMPENABLE} \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
        --with-qmp=${INSTALLDIR}/qmp \
	CXXFLAGS="" CFLAGS=""   --enable-lapack=lapack \
        LIBS=" -llapack -lblas -framework Accelerate"\
        --enable-sse-scalarsite-bicgstab-kernels \
        --with-qla=${INSTALLDIR}/qla \
        --with-qio=${INSTALLDIR}/qio \
        --with-qdpc=${INSTALLDIR}/qdpc \
        --with-qopqdp=${INSTALLDIR}/qopqdp \
        --enable-qop-mg \
	--enable-site-tests \
        --host=x86_64-linux-gnu --build=none

${MAKE}
${MAKE} install

popd
