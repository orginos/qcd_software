#./purge_build.sh
#./purge_install.sh

# Build everything
./build_qmp.sh
./build_libxml2.sh
./build_qdp++-tbb.sh
#./build_qdp++-double-tbb.sh
./build_dslash_avx_s4.sh
#./build_dslash_avx_s8.sh
./build_chroma.sh
#./build_chroma-double.sh
