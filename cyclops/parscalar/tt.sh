#!/bin/bash 


# Build the MG Train...
./build_qla.sh
./build_qio.sh
./build_qdpc.sh 
./build_qopqdp.sh

./build_qdp++.sh
./build_chroma.sh

./build_qdp++-double.sh
./build_chroma-double.sh
