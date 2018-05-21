\rm -rf build
\rm -rf install

./build_libxml2.sh

# Build everything
./build_qmp.sh
./build_qdp++-tbb.sh
./build_qdp++-tbb_3d.sh
./build_dslash_avx_s4.sh
#./build_qdp++-double-tbb.sh

./build_harom.sh
./build_chroma.sh
./build_wm_chroma.sh
./build_chroma_qphix.sh
./build_wm_chroma_qphix.sh

#./build_chroma-double.sh
