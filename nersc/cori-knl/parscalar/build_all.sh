#!/bin/bash 

#BUILD QDP++ AND CHROMA IN PARALLEL WITHOUT QUDA
./purge_build.sh
./purge_install.sh

# Build LIBXML2 needed by QDP++ and Chroma
./build_libxml2.sh

# Build QMP needed by QDP++ and Chroma
./build_qmp.sh
./build_qdp++.sh
./build_qdp++-double.sh

# Build QPhiX
./build_qphix_cmake.sh
./build_qphix_cmake-double.sh

# Build the MG Train...
#./build_qla.sh
#./build_qio.sh
#./build_qdpc.sh 
#./build_qopqdp.sh

# Build MDWF
#./build_mdwf.sh


./build_chroma.sh
./build_wm_chroma.sh

./build_chroma-double.sh
./build_wm_chroma-double.sh

