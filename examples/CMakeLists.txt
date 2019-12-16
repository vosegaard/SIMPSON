
ExternalProject_Add (numdiff
  PREFIX numdiff
  URL http://mirror.netcologne.de/savannah/numdiff/numdiff-5.9.0.tar.gz
  #URL_HASH MD5=550737c06f4d6ea6c156800169d8f0d9
  CONFIGURE_COMMAND <SOURCE_DIR>/configure --prefix=<INSTALL_DIR>
  #BUILD_COMMAND make
  #INSTALL_COMMAND make install
  )
ExternalProject_Get_Property (numdiff install_dir)
set (NUMDIFF_INSTALL "${install_dir}")
message ("numdiff in: ${NUMDIFF_INSTALL}")
#set (NFFT3_LIBRARIES "${install_dir}/lib/libnfft3.a")
#include_directories ("${NFFT3_INCLUDE_DIRS}")

add_test (basic testall.sh ${NUMDIFF_INSTALL})
