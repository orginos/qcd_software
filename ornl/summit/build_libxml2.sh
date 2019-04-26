#!/bin/bash
#
#################
# BUILD QMP
#################
source env.sh

pushd ${BUILDDIR}

if [ -d ./build_libxml2 ]; 
then 
  rm -rf ./build_libxml2
fi

mkdir  ./build_libxml2
cd ./build_libxml2

${SRCDIR}/libxml2/configure --prefix=${INSTALLDIR}/libxml2 -host=x86_64-unknown-linux \
    --build=x86_64-suse-linux \
    CC="${PK_CC}" \
    CFLAGS="${PK_CFLAGS}" \
    --disable-shared \
    --without-zlib \
    --without-python \
    --without-readline \
    --without-threads \
    --without-history \
    --without-reader \
    --without-writer \
    --with-output \
    --without-ftp \
    --without-http \
    --without-pattern \
    --without-catalog \
    --without-docbook \
    --without-iconv \
    --without-schemas \
    --without-schematron \
    --without-modules \
    --without-xptr \
    --without-xinclude

cp Makefile Makefile.bak
sed -e 's/runsuite\$(EXEEXT)//' Makefile | sed -e 's/runtest\$(EXEEXT)\s\\//' > Makefile.new
cp Makefile.new Makefile
${MAKE}
${MAKE} install

popd
