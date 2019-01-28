\rm -rf build
\rm -rf install

./build_libxml2.sh

# Build everything
./build_qmp.sh
./build_qdp++.sh
./build_qdp++-double.sh
./build_qdp++_3d.sh
./build_qdp++-double_3d.sh
./build_qphix_cmake.sh
./build_qphix_cmake-double.sh*
./build_mgproto_cmake.sh
./build_mgproto_cmake-double.sh

./build_chroma.sh
./build_chroma-double.sh
./build_wm_chroma.sh
./build_wm_chroma-double.sh 

./build_harom.sh

#./build_chroma-double.sh
