#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
autoreconf -i -f 
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma ]; 
then 
  rm -rf ./build_chroma
fi

mkdir  ./build_chroma
cd ./build_chroma


${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma \
	--with-qdp=${INSTALLDIR}/qdp++ \
        --enable-cpp-wilson-dslash ${OMPENABLE} \
        --with-qmp=${INSTALLDIR}/qmp \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="${PK_CXXFLAGS}" CFLAGS="${PK_CFLAGS}" \
        --enable-sse-scalarsite-bicgstab-kernels --host=x86_64-linux-gnu --build=none \
	--with-qmp=${INSTALLDIR}/qmp \
        --with-qla=${INSTALLDIR}/qla \
        --with-qio=${INSTALLDIR}/qio \
        --with-qdpc=${INSTALLDIR}/qdpc \
        --with-qopqdp=${INSTALLDIR}/qopqdp \
        --enable-qop-mg \
	--enable-site-tests

# \
#	--with-mdwf=${INSTALLDIR}/mdwf \


${MAKE}
${MAKE} check
#make xcheck

${MAKE} install

popd
