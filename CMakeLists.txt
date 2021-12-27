cmake_minimum_required(VERSION 3.16)

# Set basic project properties
project(MyProject
    VERSION 0.1
    DESCRIPTION "A wonderful Fortran project built with CMake"
    LANGUAGES Fortran
)

# Set up install directories
include(GNUInstallDirs)
set(INSTALL_INCLUDEDIR "${CMAKE_INSTALL_INCLUDEDIR}/myproject")
set(INSTALL_MODULEDIR "${INSTALL_INCLUDEDIR}/fmod")

# Include project specific CMake functions
include(cmake/MyProject.cmake)

# Include user customizable config settings
include(config.cmake)

# Configure the build type (see cmake/MyProject.cmake)
configure_build_type()

# Configure the compiler flags (see cmake/MyProject.cmake)
configure_compiler_flags()

# Build library
add_subdirectory(src)

# Build applications
add_subdirectory(app)

# Build tests
enable_testing()
add_subdirectory(test)


#
# Install package config find, so that other CMake project can find this project
#
include(CMakePackageConfigHelpers)

# Add an alias to export library 'myproject' as target MyProject::MyProject
add_library(MyProject INTERFACE)
target_link_libraries(MyProject INTERFACE myproject)
install(TARGETS MyProject EXPORT myproject-targets)

# If project uses customized finders, they should be installed with it
if(EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules)
install(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/cmake/Modules
    DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/myproject
)
endif()

# Install project, add namespace
install(
    EXPORT myproject-targets
    FILE "myproject-targets.cmake"
    NAMESPACE "MyProject::"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/myproject"
)

# Create and install CMake package config file
configure_package_config_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/cmake/export/myproject-config.cmake.in"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/myproject-config.cmake"
    INSTALL_DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/myproject"
)
write_basic_package_version_file(
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/myproject-config-version.cmake"
    VERSION "${PROJECT_VERSION}"
    COMPATIBILITY SameMajorVersion
)
install(
    FILES "${CMAKE_CURRENT_BINARY_DIR}/cmake/myproject-config.cmake"
    "${CMAKE_CURRENT_BINARY_DIR}/cmake/myproject-config-version.cmake"
    DESTINATION "${CMAKE_INSTALL_LIBDIR}/cmake/myproject"
)
