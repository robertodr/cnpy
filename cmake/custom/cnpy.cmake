find_package(ZLIB REQUIRED)

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${PROJECT_BINARY_DIR}/lib)

list(APPEND _sources cnpy.cpp cnpy.h)
include_directories(${PROJECT_BINARY_DIR}/include)

if(NOT STATIC_LIBRARY_ONLY)
  add_library(${PROJECT_NAME}-shared
    SHARED
    ${_sources}
    )
  set_target_properties(${PROJECT_NAME}-shared
    PROPERTIES SOVERSION ${PROJECT_VERSION_MAJOR}
               POSITION_INDEPENDENT_CODE 1
               INTERPROCEDURAL_OPTIMIZATION 1
               CXX_VISIBILITY_PRESET hidden
               VISIBILITY_INLINES_HIDDEN 1
               OUTPUT_NAME "cnpy"
               EXPORT_NAME "cnpy"
    )
  install(TARGETS ${PROJECT_NAME}-shared
    EXPORT "${PROJECT_NAME}Targets-shared"
    RUNTIME DESTINATION ${CMAKE_INSTALL_LIBDIR}
    LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
    )
endif()

if(NOT SHARED_LIBRARY_ONLY)
  add_library(${PROJECT_NAME}-static
    STATIC
    ${_sources}
    )
  set_target_properties(${PROJECT_NAME}-static
    PROPERTIES COMPILE_FLAGS -D${PROJECT_NAME}_STATIC_DEFINE
               POSITION_INDEPENDENT_CODE 1
               INTERPROCEDURAL_OPTIMIZATION 1
               OUTPUT_NAME "cnpy"
               EXPORT_NAME "cnpy"
    )
  install(TARGETS ${PROJECT_NAME}-static
    EXPORT "${PROJECT_NAME}Targets-static"
    ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
    )
endif()

if(STATIC_LIBRARY_ONLY)
  add_library(${PROJECT_NAME} ALIAS ${PROJECT_NAME}-static)
else()
  add_library(${PROJECT_NAME} ALIAS ${PROJECT_NAME}-shared)
endif()

install(FILES ${PROJECT_BINARY_DIR}/include/${PROJECT_NAME}_export.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})
install(FILES ${PROJECT_SOURCE_DIR}/${PROJECT_NAME}.h DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/${PROJECT_NAME})

# <<<  Export interface  >>>

if(NOT STATIC_LIBRARY_ONLY)
  if (APPLE)
    set_target_properties(${PROJECT_NAME}-shared PROPERTIES LINK_FLAGS "-undefined dynamic_lookup")
  endif()
  target_compile_definitions(${PROJECT_NAME}-shared INTERFACE USING_${PROJECT_NAME})
  target_include_directories(${PROJECT_NAME}-shared INTERFACE $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
endif()

if(NOT SHARED_LIBRARY_ONLY)
  target_compile_definitions(${PROJECT_NAME}-static INTERFACE USING_${PROJECT_NAME})
  target_include_directories(${PROJECT_NAME}-static INTERFACE $<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>)
endif()

# <<<  Export Config  >>>

# explicit "share" not "DATADIR" for CMake search path
set (CMAKECONFIG_INSTALL_DIR "share/cmake/${PROJECT_NAME}")
if(NOT STATIC_LIBRARY_ONLY)
  install (EXPORT "${PROJECT_NAME}Targets-shared"
    NAMESPACE "${PROJECT_NAME}::"
    DESTINATION ${CMAKECONFIG_INSTALL_DIR})
endif()

if(NOT SHARED_LIBRARY_ONLY)
  install (EXPORT "${PROJECT_NAME}Targets-static"
    NAMESPACE "${PROJECT_NAME}::"
    DESTINATION ${CMAKECONFIG_INSTALL_DIR})
endif()
