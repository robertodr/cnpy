file(COPY mat2npz npy2mat npz2mat
  DESTINATION ${CMAKE_CURRENT_BINARY_DIR}
  )

add_executable(test_cxx11 test_cxx11.cpp)
target_link_libraries(test_cxx11 cnpy)
target_include_directories(test_cxx11 PRIVATE ${PROJECT_SOURCE_DIR})
add_test(test_cxx11 ${PROJECT_BINARY_DIR}/bin/test_cxx11)

add_executable(test_cxx98 test_cxx98.cpp)
target_link_libraries(test_cxx98 cnpy)
target_include_directories(test_cxx98 PRIVATE ${PROJECT_SOURCE_DIR})
add_test(test_cxx98 ${PROJECT_BINARY_DIR}/bin/test_cxx98)
