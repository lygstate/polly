if(DEFINED POLLY_COMPILER_VXWORKS_PPC_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_VXWORKS_PPC_CMAKE_ 1)
endif()

find_program(CMAKE_C_COMPILER ccppc)
find_program(CMAKE_CXX_COMPILER c++ppc)
if(NOT CMAKE_C_COMPILER)
  polly_fatal_error("ccppc not found")
endif()

if(NOT CMAKE_CXX_COMPILER)
  polly_fatal_error("c++ppc not found")
endif()

set(CMAKE_NM_VXWORKS_NAME nmppc)
set(
  CMAKE_C_CXX_COMPILER_FLAGS_VXWORKS
  "-mcpu=860 -DCPU=PPC860"
)

include("${CMAKE_CURRENT_LIST_DIR}/vxworks.cmake")
