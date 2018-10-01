##===--------------------------------------------------------------------------
##                   ROCm Device Libraries
##
## This file is distributed under the University of Illinois Open Source
## License. See LICENSE.TXT for details.
##===--------------------------------------------------------------------------

# -Wno-error=atomic-alignment was added to workaround build problems due to potential mis-aligned atomic ops detected by clang
set (CLANG_OCL_FLAGS "-Werror -Wno-error=atomic-alignment -x cl -Xclang -cl-std=CL2.0 -target ${AMDGPU_TARGET_TRIPLE} -fvisibility=protected -Xclang -finclude-default-header ${CLANG_OPTIONS_APPEND}")
set (CLANG_OCL_LINK_FLAGS "-target ${AMDGPU_TARGET_TRIPLE} -mcpu=fiji")

set (LLVM_LINK "${LLVM_TOOLS_BINARY_DIR}/llvm-link")
set (LLVM_OBJDUMP "${LLVM_TOOLS_BINARY_DIR}/llvm-objdump")
set (LLVM_OPT "${LLVM_TOOLS_BINARY_DIR}/opt")

set (BC_EXT .bc)
set (LIB_SUFFIX ".lib${BC_EXT}")
set (STRIP_SUFFIX ".strip${BC_EXT}")
set (FINAL_SUFFIX ".amdgcn${BC_EXT}")
set (CMAKE_INCLUDE_FLAG_OCL "-I")
set (CMAKE_OCL_COMPILER_ENV_VAR OCL)
set (CMAKE_OCL_OUTPUT_EXTENTION ${BC_EXT})
set (CMAKE_OCL_COMPILER ${LLVM_TOOLS_BINARY_DIR}/clang)
set (CMAKE_OCL_COMPILE_OBJECT "${CMAKE_OCL_COMPILER} <INCLUDES> -o <OBJECT> <FLAGS> -c <SOURCE>")
set (CMAKE_OCL_LINK_EXECUTABLE "${CMAKE_COMMAND} -E copy <OBJECTS> <TARGET>")
set (CMAKE_OCL_CREATE_STATIC_LIBRARY "${LLVM_LINK} -o <TARGET> <OBJECTS>")
set (CMAKE_OCL_SOURCE_FILE_EXTENSIONS "cl")
set (CMAKE_EXECUTABLE_SUFFIX_OCL ".co")

macro(opencl_bc_lib name)
  get_target_property(irif_lib_output irif_lib OUTPUT_NAME)

  set(impl_lib_tgt ${name}_lib_impl)
  set(final_lib_tgt ${name}_lib)

  list(APPEND AMDGCN_LIB_LIST ${final_lib_tgt})
  set(AMDGCN_LIB_LIST ${AMDGCN_LIB_LIST} PARENT_SCOPE)
  foreach(file ${ARGN})
    get_filename_component(fext ${file} EXT)
    #mark files as OCL source
    if (fext STREQUAL ".cl")
      set_source_files_properties(${file} PROPERTIES
        OBJECT_DEPENDS "${CMAKE_OCL_COMPILER}"
        LANGUAGE "OCL")
    endif()
    #mark files as OCL object to add them to link
    if (fext STREQUAL ".ll")
      set_source_files_properties(${file} PROPERTIES EXTERNAL_OBJECT TRUE)
    endif()
  endforeach()

  add_library(${impl_lib_tgt} STATIC ${ARGN})
  add_dependencies(${impl_lib_tgt} irif_lib)

  if(NOT ROCM_DEVICELIB_STANDALONE_BUILD)
    add_dependencies(${impl_lib_tgt} llvm-link clang opt llvm-objdump)
  endif()

  set_target_properties(${impl_lib_tgt} PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    ARCHIVE_OUTPUT_NAME "${name}"
    PREFIX "" SUFFIX ${LIB_SUFFIX}
    COMPILE_FLAGS "${CLANG_OCL_FLAGS} -emit-llvm -Xclang -mlink-builtin-bitcode -Xclang ${irif_lib_output}"
    LINK_DEPENDS ${LLVM_LINK}
    LANGUAGE "OCL" LINKER_LANGUAGE "OCL")
  set(strip_name "${name}${STRIP_SUFFIX}")
  set(final_name "${name}${FINAL_SUFFIX}")

  if (TARGET prepare-builtins)
    add_dependencies(${impl_lib_tgt} prepare-builtins)
  endif()

  add_custom_command(TARGET ${impl_lib_tgt}
    POST_BUILD
    COMMAND ${LLVM_OPT} -strip -o ${strip_name} $<TARGET_FILE:${impl_lib_tgt}>
    COMMAND ${PREPARE_BUILTINS} ${strip_name} -o ${final_name}
    DEPENDS ${lib_tgt}
    COMMENT "Generating ${final_name}")

  add_custom_target(${final_lib_tgt})
  add_dependencies(${final_lib_tgt} ${impl_lib_tgt})

  set_target_properties(${final_lib_tgt} PROPERTIES
    ARCHIVE_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
    ARCHIVE_OUTPUT_NAME "${name}"
    PREFIX "" SUFFIX "${FINAL_SUFFIX}")

  install (FILES "${CMAKE_CURRENT_BINARY_DIR}/${final_name}"
    DESTINATION lib COMPONENT device-libs)
endmacro()

function(clang_opencl_code name dir)
  set(tgt_name ${name}_code)
  set_source_files_properties(${dir}/${name}.cl PROPERTIES LANGUAGE "OCL")
  add_executable(${tgt_name} ${dir}/${name}.cl)
  set(mlink_flags)
  foreach (lib ${ARGN})
    add_dependencies(${tgt_name} ${lib}_lib)
    get_target_property(lib_file ${lib}_lib ARCHIVE_OUTPUT_NAME)
    get_target_property(lib_path ${lib}_lib ARCHIVE_OUTPUT_DIRECTORY)
    get_target_property(lib_prefix ${lib}_lib PREFIX)
    get_target_property(lib_suffix ${lib}_lib SUFFIX)
    set(mlink_flags "${mlink_flags} -Xclang -mlink-bitcode-file -Xclang ${lib_path}/${lib_prefix}${lib_file}${lib_suffix}")
  endforeach()
  set(test_build_flags "${CMAKE_OCL_FLAGS} -mcpu=fiji ${mlink_flags}")
  #dummy link since clang already generated CodeObject file
  set_target_properties(${tgt_name} PROPERTIES
    COMPILE_FLAGS "${CLANG_OCL_FLAGS} ${test_build_flags}"
    LANGUAGE "OCL" LINKER_LANGUAGE "OCL")
endfunction()

set (oclc_default_libs
  oclc_correctly_rounded_sqrt_off
  oclc_daz_opt_off
  oclc_finite_only_off
  oclc_isa_version_803
  oclc_unsafe_math_off
)

macro(clang_opencl_test name dir)
  clang_opencl_code(${name} ${dir} hip opencl ocml ockl ${oclc_default_libs})
  add_test(
    NAME ${name}:llvm-objdump
    COMMAND ${LLVM_OBJDUMP} -disassemble -mcpu=fiji $<TARGET_FILE:${name}_code>
  )
  if(AMDHSACOD)
    add_test(
      NAME ${name}:amdhsacod
      COMMAND ${AMDHSACOD} -test -code $<TARGET_FILE:${name}_code>
    )
  endif()
endmacro()

macro(clang_opencl_test_file dir fname)
  get_filename_component(name ${fname} NAME_WE)
  get_filename_component(fdir ${fname} DIRECTORY)
  clang_opencl_test(${name} ${dir}/${fdir})
endmacro()
