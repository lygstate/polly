# Copyright (c) 2015, Ruslan Baratov
# All rights reserved.

if(DEFINED POLLY_COMPILER_VXWORKS_PENTIUM_CMAKE_)
  return()
else()
  set(POLLY_COMPILER_VXWORKS_PENTIUM_CMAKE_ 1)
endif()

find_program(CMAKE_C_COMPILER ccpentium)
find_program(CMAKE_CXX_COMPILER c++pentium)
find_program(CMAKE_NM_VXWORKS_PENTIUM nmpentium)
find_program(CMAKE_WTXTCL_VXWORKS_PENTIUM wtxtcl)

set (CMAKE_WTXTCL_VXWORKS_PENTIUM_TCL "C:\\Tornado2.2\\host\\src\\hutils\\munch.tcl")

if(NOT CMAKE_C_COMPILER)
  polly_fatal_error("ccpentium not found")
endif()

if(NOT CMAKE_CXX_COMPILER)
  polly_fatal_error("c++pentium not found")
endif()

set(
  CMAKE_C_COMPILER
  "${CMAKE_C_COMPILER}"
  CACHE
  STRING
  "C compiler"
  FORCE
)

set(
  CMAKE_CXX_COMPILER
  "${CMAKE_CXX_COMPILER}"
  CACHE
  STRING
  "C++ compiler"
  FORCE
)
set(
  CMAKE_C_CXX_COMPILER_FLAGS_VXWORKS_PENTIUM
  "-g -mcpu=pentiumiii -march=p3 -ansi -nostdlib -fno-builtin -fno-defer-pop \"-IC:\\Tornado2.2\\target\\h\" -DCPU=PENTIUM4 -DTOOL_FAMILY=gnu -DTOOL=gnu"
)
set(
  CMAKE_C_FLAGS
  ${CMAKE_C_CXX_COMPILER_FLAGS_VXWORKS_PENTIUM}
  CACHE
  STRING
  "C compiler flags"
  FORCE
)

set(
  CMAKE_CXX_FLAGS
  ${CMAKE_C_CXX_COMPILER_FLAGS_VXWORKS_PENTIUM}
  CACHE
  STRING
  "C++ compiler flags"
  FORCE
)

set(
  CMAKE_C_LINK_EXECUTABLE
  "\"${CMAKE_COMMAND}\" -E echo <OBJECTS> > <TARGET>.lst"
  "\"${CMAKE_C_COMPILER}\" -r -nostdlib -Wl,-X -Wl,@<TARGET>.lst -o <TARGET>.partialImage.o"
  "\"${CMAKE_NM_VXWORKS_PENTIUM}\" -g <TARGET>.partialImage.o @<TARGET>.lst > <TARGET>.second.o"
  "\"${CMAKE_CURRENT_LIST_DIR}/vxworks_pentium_wtxtcl.bat\" <TARGET>.second.o ${CMAKE_WTXTCL_VXWORKS_PENTIUM} ${CMAKE_WTXTCL_VXWORKS_PENTIUM_TCL} <TARGET>.ctdt.c"
  "\"${CMAKE_C_COMPILER}\" -fdollars-in-identifiers ${CMAKE_C_FLAGS} -c <TARGET>.ctdt.c -o <TARGET>.ctdt.o"
  "\"${CMAKE_C_COMPILER}\" -r -nostdlib -Wl,-X -T C:/Tornado2.2/target/h/tool/gnu/ldscripts/link.OUT <TARGET>.partialImage.o <TARGET>.ctdt.o -o <TARGET>.out"
)

set(
  "\"${CMAKE_COMMAND}\" -E echo <OBJECTS> > <TARGET>.lst"
  "\"${CMAKE_CXX_COMPILER}\" -r -nostdlib -Wl,-X -Wl,@<TARGET>.lst -o <TARGET>.partialImage.o"
  "\"${CMAKE_NM_VXWORKS_PENTIUM}\" -g <TARGET>.partialImage.o @<TARGET>.lst > <TARGET>.second.o"
  "\"${CMAKE_CURRENT_LIST_DIR}/vxworks_pentium_wtxtcl.bat\" <TARGET>.second.o ${CMAKE_WTXTCL_VXWORKS_PENTIUM} ${CMAKE_WTXTCL_VXWORKS_PENTIUM_TCL} <TARGET>.ctdt.c"
  "\"${CMAKE_CXX_COMPILER}\" -fdollars-in-identifiers ${CMAKE_C_FLAGS} -c <TARGET>.ctdt.c -o <TARGET>.ctdt.o"
  "\"${CMAKE_CXX_COMPILER}\" -r -nostdlib -Wl,-X -T C:/Tornado2.2/target/h/tool/gnu/ldscripts/link.OUT <TARGET>.partialImage.o <TARGET>.ctdt.o -o <TARGET>.out"
)
