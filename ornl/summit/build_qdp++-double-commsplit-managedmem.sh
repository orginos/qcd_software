#!/bin/bash
#
#################
# BUILD QMP
#################
source ./env.sh

pushd ${SRCDIR}/qdp-jit-llvm-nvptx

if [ -f ./include/qdp_libdevice.h ];
then
   echo "QDP-JIT LibDevice already patched. Cleaning"
   rm -rf ./libdevice_files
   rm -f ./include/qdp_libdevice.h
   rm -f ./lib/qdp_libdevice.cc
fi

echo "QDP-JIT adding LibDevice patch"
mkdir -p ./libdevice_files
cp ${PK_CUDA_HOME}/nvvm/libdevice/* ./libdevice_files
pushd ./libdevice_files
CUDA_MAJOR=`nvcc --version | grep release | awk '{ print $6}' | cut -f2 -dV | cut -f1 -d.`
case ${CUDA_MAJOR} in
7|8)
      echo CUDA v7 or 8.
      case ${SM} in
      sm_30)
        LIBDEVICE_FILE="libdevice.compute_30.10.bc"
        ;;
      sm_35)
        # Use SM_35 Libdevice file
        LIBDEVICE_FILE="libdevice.compute_35.10.bc"
        ;;
      sm_37)
        # Use SM_35 Libdevice file
        LIBDEVICE_FILE="libdevice.compute_35.10.bc"
        ;;
      sm_5*)
 	# Use SM_50 libdevice file
        LIBDEVICE_FILE="libdevice.compute_50.10.bc"
        ;;
      sm_6*)
	# Use SM_30 Libdevice file for SM_60 (Kate told me this)
        LIBDEVICE_FILE="libdevice.compute_30.10.bc"
        ;;
      *)
        echo "That I dont know which libdevice file to use for that ${SM}"
        echo "For SMs more recent than SM_60, please use CUDA-9 or better"
        exit -1
        ;;
      esac
      echo "SM is ${SM} : Copying ${LIBDEVICE_FILE} to ./libdevice.bc"
      cp ${LIBDEVICE_FILE} libdevice.bc
      ;;

9) 
      MY_SM=`echo ${SM} | cut -f2 -d'_'`
      echo CUDA v9. Copying libdevice.10.bc to libdevice.compute_${MY_SM}.10.bc
      mv libdevice.10.bc libdevice.bc
      ;;
*)
     echo Unknown CUDA Version
      ;;
esac
popd ## libdevice_files
./pack_libdevice.sh ./libdevice_files
popd

pushd ${SRCDIR}/qdp-jit-llvm-nvptx
autoreconf
popd

pushd ${BUILDDIR}

if [ -d ./build_qdp++-double ]; 
then 
  rm -rf ./build_qdp++-double
fi

mkdir  ./build_qdp++-double
cd ./build_qdp++-double

echo $LD_LIBRARY_PATH
sleep 5
${SRCDIR}/qdp-jit-llvm-nvptx/configure \
	--prefix=${INSTALLDIR}/qdp++-double \
	--with-libxml2=${INSTALLDIR}/libxml2 \
	--with-qmp=${INSTALLDIR}/qmp \
        --enable-parallel-arch=parscalar \
	--enable-precision=double \
	--enable-largefile \
	--enable-parallel-io \
        --enable-dml-output-buffering \
        --disable-generics \
        --with-cuda=${PK_CUDA_HOME} \
	--with-llvm=${LLVM_INSTALL_DIR} \
	--enable-comm-split-deviceinit \
	--enable-cuda-managed-memory \
        CXXFLAGS="${PK_CXXFLAGS}" \
	CFLAGS="${PK_CFLAGS}" \
	LDFLAGS="${PK_LDFLAGS}" \
	LIBS="-ldl -lpthread" \
	CXX="${PK_CXX}" \
	CC="${PK_CC}" \
	--host=x86_64-linux-gnu --build=none \
	${OMPENABLE}

#  --enable-comm-split-deviceinit \
${MAKE}
${MAKE} install

popd
