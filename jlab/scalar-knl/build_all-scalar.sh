#!/bin/bash 

#BUILD QDP++ AND CHROMA IN PARALLEL WITHOUT QUDA
./purge_build.sh
./purge_install.sh

./build_libxml2.sh

#the spectroscopy tools
./build_adat.sh
./build_colorvec.sh
./build_tensor.sh
./build_hadron.sh
./build_redstar.sh

# BUILD Single Prec QDP++ -- sufficient for tutorials
./build_qdp++-scalar.sh
./build_qdp++-scalar_3d.sh


#Here is where HAROM builds
./build_harom.sh

# IF you feel brave you can build chroma too
./build_chroma.sh

#
#./build_qdp++-double-scalar.sh
#./build_chroma-double-scalar.sh
