if(DEFINED POLLY_COMPILER_VXWORKS_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_VXWORKS_CMAKE_ 1)
endif()

set(
  WIND_BASE
  $ENV{WIND_BASE}
  CACHE
  PATH
  "Tornado Base Dir"
  FORCE
)

include(polly_add_cache_flag)

polly_add_cache_flag(CMAKE_C_COMPILER_ID "VxWorksGNU")
polly_add_cache_flag(CMAKE_CXX_COMPILER_ID "VxWorksGNU")
polly_add_cache_flag(CMAKE_SYSTEM_NAME "Generic")

set (CMAKE_WTXTCL_VXWORKS_MUNCH_TCL "${WIND_BASE}/host/src/hutils/munch.tcl")
set (CMAKE_LDSCRIPT_VXWORKS "${WIND_BASE}/target/h/tool/gnu/ldscripts/link.OUT")
set (CMAKE_TARGET_H_VXWORKS "${WIND_BASE}/target/h")

function (find_gcc_tool CMAKE_VARIABLE_NAME TOOL_NAME TOOL_DESCRIPTION IS_FULL)
  if(IS_FULL)
    set(TOOL_FULLNAME ${TOOL_NAME})
  else()
    set(TOOL_FULLNAME ${TOOL_NAME}${CMAKE_VXWORKS_ARCH_NAME})
  endif()
  # message("Finding ${TOOL_FULLNAME}")
  find_program(${CMAKE_VARIABLE_NAME} ${TOOL_FULLNAME})
  if(NOT ${CMAKE_VARIABLE_NAME})
    polly_fatal_error("${TOOL_FULLNAME} not found")
  endif()
  set(
    ${CMAKE_VARIABLE_NAME}
    "${${CMAKE_VARIABLE_NAME}}"
    CACHE
    PATH
    "${TOOL_DESCRIPTION}"
    FORCE
  )
endfunction ()


find_gcc_tool(CMAKE_C_COMPILER cc "C Compiler" OFF)
find_gcc_tool(CMAKE_CXX_COMPILER c++ "C++ Compiler" OFF)
find_gcc_tool(CMAKE_ASM_COMPILER as "Assembler" OFF)
find_gcc_tool(CMAKE_C_PREPROCESSOR cpp "Preprocessor" OFF)
find_gcc_tool(CMAKE_STRIP strip "strip" OFF)
find_gcc_tool(CMAKE_AR ar "Archiver" OFF)
find_gcc_tool(CMAKE_LINKER ld "Linker" OFF)
find_gcc_tool(CMAKE_NM nm "nm" OFF)
find_gcc_tool(CMAKE_OBJCOPY objcopy "objcopy" OFF)
find_gcc_tool(CMAKE_OBJDUMP objdump "objdump" OFF)
find_gcc_tool(CMAKE_RANLIB ranlib "ranlib" OFF)

set(CMAKE_TOOLCHAIN_FILE "${CMAKE_TOOLCHAIN_FILE}" CACHE PATH "CMake toolchain file" FORCE)

find_gcc_tool(CMAKE_WTXTCL_VXWORKS wtxtcl "wtxtcl" ON)

set(CMAKE_C_CXX_COMPILER_FLAGS_BSP
  "${CMAKE_C_CXX_COMPILER_FLAGS_BSP_${CMAKE_VXWORKS_BSP_NAME}}")

set(
  CMAKE_C_FLAGS
  "${CMAKE_C_CXX_COMPILER_FLAGS_BSP} -g -ansi -nostdlib -fno-builtin -DTOOL_FAMILY=gnu -DTOOL=gnu -I${CMAKE_TARGET_H_VXWORKS}"
  CACHE
  STRING
  "C compiler flags"
  FORCE
)

set(
  CMAKE_C_LINK_FLAGS
  "-r -nostdlib -Wl,-X"
  CACHE
  STRING
  "C link flags"
  FORCE
)

set(
  CMAKE_C_COMPILE_OBJECT
  "<CMAKE_C_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>"
)

set(
  CMAKE_CXX_FLAGS
  "${CMAKE_C_CXX_COMPILER_FLAGS_BSP} -g -ansi -nostdlib -fno-builtin -DTOOL_FAMILY=gnu -DTOOL=gnu -I${CMAKE_TARGET_H_VXWORKS}"
  CACHE
  STRING
  "C++ compiler flags"
  FORCE
)

set(
  CMAKE_CXX_COMPILE_OBJECT
  "<CMAKE_CXX_COMPILER> <DEFINES> <INCLUDES> <FLAGS> -o <OBJECT> -c <SOURCE>"
)


set(_CMAKE_VXWORKS_SHARED_LINK_COMMAND_ARGS
  "\
  \"-DFLAGS=<FLAGS>\" \
  \"-DLINK_FLAGS=<LINK_FLAGS>\" \
  \"-DOBJECTS=<OBJECTS>\" \
  \"-DTARGET=<TARGET>\" \
  \"-DLINK_LIBRARIES=<LINK_LIBRARIES>\" \
  \"-DCMAKE_NM=${CMAKE_NM}\" \
  \"-DCMAKE_WTXTCL_VXWORKS=${CMAKE_WTXTCL_VXWORKS}\" \
  \"-DCMAKE_WTXTCL_VXWORKS_MUNCH_TCL=${CMAKE_WTXTCL_VXWORKS_MUNCH_TCL}\" \
  \"-DCMAKE_VXWORKS_ARCH_NAME=${CMAKE_VXWORKS_ARCH_NAME}\" \
  \"-DCMAKE_LDSCRIPT_VXWORKS=${CMAKE_LDSCRIPT_VXWORKS}\" \
  -P ${CMAKE_CURRENT_LIST_DIR}/vxworks-link.cmake"
)

set(
  CMAKE_C_LINK_EXECUTABLE
  "\
  \"${CMAKE_COMMAND}\" \
  \"-DCMAKE_COMPILER=<CMAKE_C_COMPILER>\" \
  \"-DCMAKE_LINK_FLAGS=<CMAKE_C_LINK_FLAGS>\" \
  ${_CMAKE_VXWORKS_SHARED_LINK_COMMAND_ARGS}"
)

set(
  CMAKE_CXX_LINK_EXECUTABLE
  "\
  \"${CMAKE_COMMAND}\" \
  \"-DCMAKE_COMPILER=<CMAKE_CXX_COMPILER>\" \
  \"-DCMAKE_LINK_FLAGS=<CMAKE_CXX_LINK_FLAGS>\" \
  ${_CMAKE_VXWORKS_SHARED_LINK_COMMAND_ARGS}"
)
