#!/bin/bash
#
#################
# BUILD QPHIX
#################
	
source env.sh

echo "*********** QPhiX START  **********"
if [[ ${HNAME} == vulcan* ]]; then
	
pushd ${SRCDIR}/qphix
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./qphix_qpx ];
then 
  rm -rf ./qphix_qpx
fi

mkdir  ./qphix_qpx
cd ./qphix_qpx

echo "Configuring QPhiX++ in ${BUILDDIR}/qphix ..."   
${SRCDIR}/qphix/configure \
	--prefix=${INSTALLDIR}/qphix \
	--with-qdp++=${INSTALLDIR}/qdp++ \
	--enable-parallel-arch=parscalar \
	--with-qmp=${INSTALLDIR}/qmp \
	--enable-clover \
	--enable-proc=QPX \
	--enable-soalen=4 \
	--disable-mm-malloc \
	CXXFLAGS="${PK_CXXFLAGS} -Drestrict=__restrict__" \
	CFLAGS="${PK_CFLAGS} -Drestrict=__restrict__" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	LDFLAGS="${PK_LDFLAGS}" \
	LIBS="${PK_LIBS}" \
	--host=powerpc64-bgq-linux \
	--build=powerpc64-unknown-linux-gnu \
	${OMPENABLE} >> ${LOGSDIR}/qphix.configure.log 2>&1

status=$?
if [ $status -ne 0 ]
then
	echo ... failed 
	exit 1;
fi

echo "Compiling QPhiX++ in ${BUILDDIR}/qphix ..."     
${MAKE} > ${LOGSDIR}/qphix.make.log 2>&1
status=$?
if [ $status -ne 0 ]
then
	echo ... failed 
	exit 1;
fi

echo "Installing QPhiX in ${INSTALLDIR}/qphix ..."
${MAKE} install > ${LOGSDIR}/qphix.install.log 2>&1
status=$?
if [ $status -ne 0 ]
then
	echo ... failed 
	exit 1;
fi


popd
fi
echo "*********** QPhiX FINISH **********"
