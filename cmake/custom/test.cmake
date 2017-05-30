option(ENABLE_TESTS "Enable tests" ON)

if(ENABLE_TESTS)
  include(CTest)
  enable_testing()
  add_subdirectory(test)
endif()
