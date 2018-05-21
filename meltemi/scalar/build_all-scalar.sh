#!/bin/bash 

#BUILD QDP++ AND CHROMA IN PARALLEL WITHOUT QUDA
\rm -rf build
\rm -rf install

./build_libxml2.sh

#the spectroscopy tools
./build_adat.sh
./build_tensor.sh
./build_hadron.sh
./build_colorvec.sh
./build_redstar.sh

# BUILD Single Prec QDP++ -- sufficient for tutorials
./build_qdp++.sh
./build_qdp++_3d.sh


#Here is where HAROM builds
./build_harom.sh

# IF you feel brave you can build chroma too
#./build_dslash_scalar_avx_s4.sh

./build_chroma.sh

#
./build_wm_chroma.sh
#
#./build_qdp++-double-scalar.sh
#./build_chroma-double-scalar.sh
