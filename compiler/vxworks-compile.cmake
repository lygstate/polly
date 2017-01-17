#message (STATUS "DEFINES ${DEFINES}")
#message (STATUS "INCLUDES ${INCLUDES}")
#message (STATUS "FLAGS ${FLAGS}")
#message (STATUS "OBJECT ${OBJECT}")
#message (STATUS "SOURCE ${SOURCE}")
#message (STATUS "CMAKE_COMPILER ${CMAKE_COMPILER}")

separate_arguments(DEFINES)
separate_arguments(INCLUDES)
separate_arguments(FLAGS)

list(FIND FLAGS -MF MF_FLAG_POS)

if(NOT(${MF_FLAG_POS} STREQUAL -1))
  #message (STATUS "FLAGS ${FLAGS}")
  list(LENGTH FLAGS FLAGS_LENGTH)
  foreach(loop_var RANGE 1 5 1)
    math(EXPR REMOVE_POS "${FLAGS_LENGTH} - ${loop_var}")
    list(REMOVE_AT FLAGS ${REMOVE_POS})
  endforeach()

  #message (STATUS "FLAGS ${FLAGS}")
endif()

# Refer to https://github.com/Kitware/CMake/blob/master/Modules/CMakeCXXInformation.cmake#L278
# Use DEPENDENCIES_OUTPUT to control the .d file generated path
# https://gcc.gnu.org/onlinedocs/gcc-2.95.3/gcc_2.html#SEC44
execute_process (
  COMMAND "${CMAKE_COMPILER}" ${DEFINES} ${INCLUDES} ${FLAGS} -o ${OBJECT} -c ${SOURCE}
)

execute_process (
  COMMAND "${CMAKE_COMPILER}" ${DEFINES} ${INCLUDES} ${FLAGS} -MM ${SOURCE}
  OUTPUT_VARIABLE DEPEND_FILE_CONTENT
)
get_filename_component(OBJECT_FILENAME "${OBJECT}" NAME)
string(REGEX REPLACE "[^:]+.o:" "${OBJECT_FILENAME}:" DEPEND_FILE_CONTENT ${DEPEND_FILE_CONTENT})
file(WRITE "${OBJECT}.d" "${DEPEND_FILE_CONTENT}")
file(WRITE "${OBJECT}.dd" "${DEPEND_FILE_CONTENT}")
