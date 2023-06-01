set(PACKAGE_PREFIX ${CMAKE_INSTALL_LIBDIR}/cmake/AMDDeviceLibs)

# Generate the build-tree package.
# We know the absolute path to the build tree, so we leave
# AMD_DEVICE_LIBS_PREFIX_CODE blank and include absolute paths in the target
# imports in AMD_DEVICE_LIBS_TARGET_CODE.
foreach(target ${AMDGCN_LIB_LIST})
  get_target_property(target_path ${target} OUTPUT_NAME)
  set(AMD_DEVICE_LIBS_TARGET_CODE "${AMD_DEVICE_LIBS_TARGET_CODE}
add_library(${target} STATIC IMPORTED)
set_target_properties(${target} PROPERTIES
  IMPORTED_LOCATION \"${target_path}\")")
endforeach()
configure_file(AMDDeviceLibsConfig.cmake.in
  ${PACKAGE_PREFIX}/AMDDeviceLibsConfig.cmake
  @ONLY)


if (WIN32)
  set(EXE_SUFFIX ".exe")
else()
  set(EXE_SUFFIX)
endif()
# Get clang install directory for installation
execute_process (
  COMMAND ${LLVM_TOOLS_BINARY_DIR}/clang${EXE_SUFFIX} --print-resource-dir
  OUTPUT_VARIABLE CLANG_RESOURCE_DIR OUTPUT_STRIP_TRAILING_WHITESPACE
)
set(install_path_suffix "amdgcn/bitcode")

# Generate the install-tree package.
set(AMD_DEVICE_LIBS_PREFIX_CODE "
set(AMD_DEVICE_LIBS_PREFIX \"${CLANG_RESOURCE_DIR}\")")
set(AMD_DEVICE_LIBS_TARGET_CODE)
foreach(target ${AMDGCN_LIB_LIST})
  get_target_property(target_name ${target} ARCHIVE_OUTPUT_NAME)
  get_target_property(target_prefix ${target} PREFIX)
  get_target_property(target_suffix ${target} SUFFIX)
  set(AMD_DEVICE_LIBS_TARGET_CODE "${AMD_DEVICE_LIBS_TARGET_CODE}
add_library(${target} STATIC IMPORTED)
set_target_properties(${target} PROPERTIES
  IMPORTED_LOCATION \"\${AMD_DEVICE_LIBS_PREFIX}/${install_path_suffix}/${target_prefix}${target_name}${target_suffix}\")")
endforeach()
configure_file(AMDDeviceLibsConfig.cmake.in
  ${CMAKE_CURRENT_BINARY_DIR}/AMDDeviceLibsConfig.cmake.install
  @ONLY)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/AMDDeviceLibsConfig.cmake.install
  DESTINATION ${PACKAGE_PREFIX}
  COMPONENT device-libs
  RENAME AMDDeviceLibsConfig.cmake)
