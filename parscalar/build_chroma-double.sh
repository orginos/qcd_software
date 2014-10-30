#!/bin/bash
#
#################
# BUILD Chroma
#################
source env.sh

pushd ${SRCDIR}/chroma
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_chroma-double ]; 
then 
  rm -rf ./build_chroma-double
fi

if [ ! -d ./build_chroma-double ];
then
 mkdir  ./build_chroma-double
fi

cd ./build_chroma-double

${SRCDIR}/chroma/configure --prefix=${INSTALLDIR}/chroma-double \
	--with-qdp=${INSTALLDIR}/qdp++-double \
        CC="${PK_CC}"  CXX="${PK_CXX}" \
	CXXFLAGS="" CFLAGS="${PK_CFLAGS}" \
        --enable-sse-scalarsite-bicgstab-kernels --host=x86_64-linux-gnu --build=none \
	--enable-cpp-wilson-dslash --enable-sse3 \
        --with-mdwf=${INSTALLDIR}/mdwf \
	--with-qla=${INSTALLDIR}/qla \
	--with-qio=${INSTALLDIR}/qio \
	--with-qdpc=${INSTALLDIR}/qdpc \
	--with-qopqdp=${INSTALLDIR}/qopqdp \
	--with-qmp=${INSTALLDIR}/qmp \
	--enable-qop-mg

${MAKE}
${MAKE} install
popd
