string(REPLACE " " "\n" LINK_LIBRARIES ${LINK_LIBRARIES})
string(REPLACE " " "\n" OBJECTS ${OBJECTS})

# message (STATUS "CMAKE_COMPILER ${CMAKE_COMPILER}")
# message (STATUS "OBJECTS ${OBJECTS}")
# message (STATUS "LINK_LIBRARIES ${LINK_LIBRARIES}")
# message (STATUS "TARGET ${TARGET}")
# message (STATUS "LINK_FLAGS ${LINK_FLAGS}")
# message (STATUS "CMAKE_LINK_FLAGS ${CMAKE_LINK_FLAGS}")
# message (STATUS "FLAGS ${FLAGS}")
# message (STATUS "CMAKE_LDSCRIPT_VXWORKS ${CMAKE_LDSCRIPT_VXWORKS}")

separate_arguments(CMAKE_LINK_FLAGS)
separate_arguments(LINK_FLAGS)
separate_arguments(FLAGS)

file(WRITE "${TARGET}.lst" "${OBJECTS}")
file(APPEND "${TARGET}.lst" "${LINK_LIBRARIES}")


# Make sure all the static library are fully included
# http://stackoverflow.com/questions/7253801/how-to-force-symbols-from-a-static-library-to-be-included-in-a-shared-library-bu
# -Wl,--whole-archive
execute_process (
  COMMAND "${CMAKE_COMPILER}" ${CMAKE_LINK_FLAGS} ${LINK_FLAGS} -Wl,--whole-archive -Wl,@${TARGET}.lst -o ${TARGET}.partialImage.o
)

execute_process (
  COMMAND "${CMAKE_NM}" -g ${TARGET}.partialImage.o @${TARGET}.lst
  OUTPUT_FILE ${TARGET}.nm
)

execute_process (
  COMMAND "${CMAKE_WTXTCL_VXWORKS}" ${CMAKE_WTXTCL_VXWORKS_MUNCH_TCL} -c ${CMAKE_VXWORKS_ARCH_NAME}
  INPUT_FILE ${TARGET}.nm
  OUTPUT_FILE ${TARGET}.ctdt.c
)

execute_process (
  COMMAND "${CMAKE_COMPILER}" -fdollars-in-identifiers ${FLAGS} -c ${TARGET}.ctdt.c -o ${TARGET}.ctdt.o
)

execute_process (
  COMMAND "${CMAKE_COMPILER}" ${CMAKE_LINK_FLAGS} ${LINK_FLAGS} -T ${CMAKE_LDSCRIPT_VXWORKS} ${TARGET}.partialImage.o ${TARGET}.ctdt.o -o ${TARGET}
)

#ccpentium -r -nostdlib -Wl,-X -Wl,@..\prjObjs.lst -o partialImage.o 
#nmpentium -g partialImage.o @..\prjObjs.lst | wtxtcl C:\Tornado2.2\host\src\hutils\munch.tcl -c pentium > ctdt.c
#ccpentium -c -fdollars-in-identifiers -g -mcpu=pentium -march=pentium -nostdlib -fno-builtin -fno-defer-pop -I. -IC:\Tornado2.2\target\h\ -I..\include -I..\src\vxworks -DCPU=PENTIUM -DTOOL_FAMILY=gnu -DTOOL=gnu ctdt.c -o ctdt.o
#ccpentium -r -nostdlib -Wl,-X -T C:\Tornado2.2\target\h\tool\gnu\ldscripts\link.OUT partialImage.o ctdt.o -o ARINC653.out
