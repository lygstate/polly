if(DEFINED POLLY_COMPILER_VXWORKS_PENTIUM_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_VXWORKS_PENTIUM_CMAKE_ 1)
endif()

find_program(CMAKE_C_COMPILER ccpentium)
find_program(CMAKE_CXX_COMPILER c++pentium)
if(NOT CMAKE_C_COMPILER)
  polly_fatal_error("ccpentium not found")
endif()

if(NOT CMAKE_CXX_COMPILER)
  polly_fatal_error("c++pentium not found")
endif()

set(CMAKE_NM_VXWORKS_NAME nmpentium)
set(
  CMAKE_C_CXX_COMPILER_FLAGS_VXWORKS
  "-mcpu=pentium -march=pentium -DCPU=PENTIUM -fno-defer-pop"
)

include("${CMAKE_CURRENT_LIST_DIR}/vxworks.cmake")

