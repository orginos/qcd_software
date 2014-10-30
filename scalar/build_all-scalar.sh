#!/bin/bash 

#BUILD QDP++ AND CHROMA IN PARALLEL WITHOUT QUDA
./purge_build.sh
./purge_install.sh

./build_libxml2.sh

# BUILD Single Prec QDP++ -- sufficient for tutorials
./build_qdp++-scalar.sh

# IF you feel brave you can build chroma too
./build_chroma-scalar.sh
#
#./build_qdp++-double-scalar.sh
#./build_chroma-double-scalar.sh
