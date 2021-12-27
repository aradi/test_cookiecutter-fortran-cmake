# Collect source files for library
set(f90-sources
    myproject.f90
)

# Collect source files from subdirectories
add_subdirectory(myproject)

# Build library
add_library(myproject ${f90-sources})

# Store generated mod-files in a separate folder
set(moddir "${CMAKE_CURRENT_BINARY_DIR}/fmod")
set_target_properties(myproject PROPERTIES
    Fortran_MODULE_DIRECTORY "${moddir}"
)

# Add mod-file directory to include search path for targets depending on the library
target_include_directories(myproject PUBLIC
    $<BUILD_INTERFACE:${moddir}>
    $<INSTALL_INTERFACE:${INSTALL_MODULEDIR}>
)

# Install the library
install(TARGETS myproject
    EXPORT myproject-targets
    LIBRARY DESTINATION "${CMAKE_INSTALL_LIBDIR}"
    PUBLIC_HEADER DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}/${INSTALL_INCLUDEDIR}"
)

# Install the folder with the modfiles (needed by projects using the library)
install(DIRECTORY "${moddir}/" DESTINATION "${INSTALL_MODULEDIR}")
