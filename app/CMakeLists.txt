set(f90-sources
    myprojectapp.f90
)

add_executable(myprojectapp ${f90-sources})
target_link_libraries(myprojectapp myproject)

install(TARGETS myprojectapp DESTINATION ${CMAKE_INSTALL_BINDIR})