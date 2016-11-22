# Copyright (c) 2016, Yonggang Luo
# All rights reserved.

if(DEFINED POLLY_NINJA_VXWORKS_5_5_PPC_CMAKE_)
  return()
else()
  set(POLLY_NINJA_VXWORKS_5_5_PPC_CMAKE_ 1)
endif()

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_init.cmake")

polly_init(
    "Ninja / Vxworks 5.5.x / PowerPC"
    "Ninja"
)

include("${CMAKE_CURRENT_LIST_DIR}/utilities/polly_common.cmake")
include(polly_add_cache_flag)

set(CMAKE_VXWORKS_ARCH_NAME ppc)
if (NOT DEFINED CMAKE_VXWORKS_BSP_NAME)
  set(CMAKE_VXWORKS_BSP_NAME PPC)
endif ()

set(
  CMAKE_C_CXX_COMPILER_FLAGS_BSP_PPC
  "-mcpu=860 -DCPU=PPC860"
)

include("${CMAKE_CURRENT_LIST_DIR}/compiler/vxworks.cmake")
polly_add_cache_flag(DCMAKE_SYSTEM_PROCESSOR "ppc")
