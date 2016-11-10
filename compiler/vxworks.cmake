find_program(CMAKE_NM_VXWORKS ${CMAKE_NM_VXWORKS_NAME})
find_program(CMAKE_WTXTCL_VXWORKS wtxtcl)
set (CMAKE_WTXTCL_VXWORKS_MUNCH_TCL "C:\\Tornado2.2\\host\\src\\hutils\\munch.tcl")
set (CMAKE_LDSCRIPT_VXWORKS "C:/Tornado2.2/target/h/tool/gnu/ldscripts/link.OUT")
set (CMAKE_TARGET_H_VXWORKS "C:\\Tornado2.2\\target\\h")


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
  CMAKE_C_FLAGS
  "${CMAKE_C_CXX_COMPILER_FLAGS_VXWORKS} -g -ansi -nostdlib -fno-builtin -DTOOL_FAMILY=gnu -DTOOL=gnu -I${CMAKE_TARGET_H_VXWORKS}"
  CACHE
  STRING
  "C compiler flags"
  FORCE
)

set(
  CMAKE_CXX_FLAGS
  "${CMAKE_C_CXX_COMPILER_FLAGS_VXWORKS} -g -ansi -nostdlib -fno-builtin -DTOOL_FAMILY=gnu -DTOOL=gnu -I${CMAKE_TARGET_H_VXWORKS}"
  CACHE
  STRING
  "C++ compiler flags"
  FORCE
)

set(
  CMAKE_C_LINK_EXECUTABLE
  "\"${CMAKE_COMMAND}\" -E echo <OBJECTS> > <TARGET>.lst"
  "\"${CMAKE_C_COMPILER}\" -r -nostdlib -Wl,-X -Wl,@<TARGET>.lst -o <TARGET>.partialImage.o"
  "\"${CMAKE_NM_VXWORKS}\" -g <TARGET>.partialImage.o @<TARGET>.lst > <TARGET>.second.o"
  "\"${CMAKE_CURRENT_LIST_DIR}/vxworks_wtxtcl.bat\" <TARGET>.second.o ${CMAKE_WTXTCL_VXWORKS} ${CMAKE_WTXTCL_VXWORKS_MUNCH_TCL} pentium <TARGET>.ctdt.c"
  "\"${CMAKE_C_COMPILER}\" -fdollars-in-identifiers ${CMAKE_C_FLAGS} -c <TARGET>.ctdt.c -o <TARGET>.ctdt.o"
  "\"${CMAKE_C_COMPILER}\" -r -nostdlib -Wl,-X -T ${CMAKE_LDSCRIPT_VXWORKS} <TARGET>.partialImage.o <TARGET>.ctdt.o -o <TARGET>.out"
)

set(
  CMAKE_CXX_LINK_EXECUTABLE
  "\"${CMAKE_COMMAND}\" -E echo <OBJECTS> > <TARGET>.lst"
  "\"${CMAKE_CXX_COMPILER}\" -r -nostdlib -Wl,-X -Wl,@<TARGET>.lst -o <TARGET>.partialImage.o"
  "\"${CMAKE_NM_VXWORKS}\" -g <TARGET>.partialImage.o @<TARGET>.lst > <TARGET>.second.o"
  "\"${CMAKE_CURRENT_LIST_DIR}/vxworks_wtxtcl.bat\" <TARGET>.second.o ${CMAKE_WTXTCL_VXWORKS} ${CMAKE_WTXTCL_VXWORKS_MUNCH_TCL} pentium <TARGET>.ctdt.c"
  "\"${CMAKE_CXX_COMPILER}\" -fdollars-in-identifiers ${CMAKE_C_FLAGS} -c <TARGET>.ctdt.c -o <TARGET>.ctdt.o"
  "\"${CMAKE_CXX_COMPILER}\" -r -nostdlib -Wl,-X -T ${CMAKE_LDSCRIPT_VXWORKS} <TARGET>.partialImage.o <TARGET>.ctdt.o -o <TARGET>.out"
)
