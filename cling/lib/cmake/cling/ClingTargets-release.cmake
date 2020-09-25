#----------------------------------------------------------------
# Generated CMake target import file for configuration "Release".
#----------------------------------------------------------------

# Commands may need to know the format version.
set(CMAKE_IMPORT_FILE_VERSION 1)

# Import target "clingInterpreter" for configuration "Release"
set_property(TARGET clingInterpreter APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(clingInterpreter PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libclingInterpreter.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS clingInterpreter )
list(APPEND _IMPORT_CHECK_FILES_FOR_clingInterpreter "${_IMPORT_PREFIX}/lib/libclingInterpreter.a" )

# Import target "clingMetaProcessor" for configuration "Release"
set_property(TARGET clingMetaProcessor APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(clingMetaProcessor PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libclingMetaProcessor.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS clingMetaProcessor )
list(APPEND _IMPORT_CHECK_FILES_FOR_clingMetaProcessor "${_IMPORT_PREFIX}/lib/libclingMetaProcessor.a" )

# Import target "clingUserInterface" for configuration "Release"
set_property(TARGET clingUserInterface APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(clingUserInterface PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libclingUserInterface.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS clingUserInterface )
list(APPEND _IMPORT_CHECK_FILES_FOR_clingUserInterface "${_IMPORT_PREFIX}/lib/libclingUserInterface.a" )

# Import target "clingUtils" for configuration "Release"
set_property(TARGET clingUtils APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(clingUtils PROPERTIES
  IMPORTED_LINK_INTERFACE_LANGUAGES_RELEASE "CXX"
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libclingUtils.a"
  )

list(APPEND _IMPORT_CHECK_TARGETS clingUtils )
list(APPEND _IMPORT_CHECK_FILES_FOR_clingUtils "${_IMPORT_PREFIX}/lib/libclingUtils.a" )

# Import target "libclingJupyter" for configuration "Release"
set_property(TARGET libclingJupyter APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(libclingJupyter PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libclingJupyter.so.5.0.0"
  IMPORTED_SONAME_RELEASE "libclingJupyter.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS libclingJupyter )
list(APPEND _IMPORT_CHECK_FILES_FOR_libclingJupyter "${_IMPORT_PREFIX}/lib/libclingJupyter.so.5.0.0" )

# Import target "libcling" for configuration "Release"
set_property(TARGET libcling APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(libcling PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libcling.so.5.0.0"
  IMPORTED_SONAME_RELEASE "libcling.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS libcling )
list(APPEND _IMPORT_CHECK_FILES_FOR_libcling "${_IMPORT_PREFIX}/lib/libcling.so.5.0.0" )

# Import target "clingDemoPlugin" for configuration "Release"
set_property(TARGET clingDemoPlugin APPEND PROPERTY IMPORTED_CONFIGURATIONS RELEASE)
set_target_properties(clingDemoPlugin PROPERTIES
  IMPORTED_LOCATION_RELEASE "${_IMPORT_PREFIX}/lib/libclingDemoPlugin.so.5.0.0"
  IMPORTED_SONAME_RELEASE "libclingDemoPlugin.so.5"
  )

list(APPEND _IMPORT_CHECK_TARGETS clingDemoPlugin )
list(APPEND _IMPORT_CHECK_FILES_FOR_clingDemoPlugin "${_IMPORT_PREFIX}/lib/libclingDemoPlugin.so.5.0.0" )

# Commands beyond this point should not need to know the version.
set(CMAKE_IMPORT_FILE_VERSION)
