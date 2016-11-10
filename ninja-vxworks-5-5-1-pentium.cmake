# Copyright (c) 2016, Yonggang Luo
# All rights reserved.

if(DEFINED POLLY_NINJA_VXWORKS_5_5_1_PENTIUM_CMAKE_)
  return()
else()
  set(POLLY_NINJA_VXWORKS_5_5_1_PENTIUM_CMAKE_ 1)
endif()
set(ENV{PATH} "$ENV{PATH}\;C:\\Tornado2.2\\host\\x86-win32\\bin")
message("PATH:" $ENV{PATH})

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Ninja / Vxworks 5.5.1 / Pentium"
    "Ninja"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
include(polly_add_cache_flag)

include("${CMAKE_CURRENT_LIST_DIR}/compiler/vxworks_pentium.cmake")


polly_add_cache_flag(CMAKE_SYSTEM_NAME "Generic")
polly_add_cache_flag(DCMAKE_SYSTEM_PROCESSOR "i386")
