file(COPY mat2npz npy2mat npz2mat
  DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
  )

add_executable(test_cxx11 test_cxx11.cpp)
target_link_libraries(test_cxx11 PRIVATE cnpy ZLIB::ZLIB)
target_include_directories(test_cxx11 PRIVATE ${PROJECT_SOURCE_DIR})
add_test(NAME test_cxx11
         COMMAND ${PROJECT_BINARY_DIR}/bin/test_cxx11
         WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})

add_executable(test_cxx98 test_cxx98.cpp)
target_link_libraries(test_cxx98 PRIVATE cnpy ZLIB::ZLIB)
target_include_directories(test_cxx98 PRIVATE ${PROJECT_SOURCE_DIR})
add_test(NAME test_cxx98
         COMMAND ${PROJECT_BINARY_DIR}/bin/test_cxx98
         WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR})
