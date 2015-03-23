#!/bin/bash 

./purge_build.sh
./purge_install.sh

./build_qmp.sh
./build_quda.sh
./build_libxml2.sh
./build_mdwf.sh 
# Lets not build single prec versions for now
./build_qdp++.sh
./build_chroma_quda.sh

#  Double prec versions
./build_qdp++-double.sh
./build_chroma-double_quda.sh
