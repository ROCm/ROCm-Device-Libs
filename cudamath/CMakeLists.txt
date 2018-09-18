##===----------------------------------------------------------------------===##
#
#                     The LLVM Compiler Infrastructure
#
# This file is dual licensed under the MIT and the University of Illinois Open
# Source Licenses. See LICENSE.txt for details.
##===----------------------------------------------------------------------===##
#
# rocm-device-libs/cudamath/CMakeLists.txt
#
##===----------------------------------------------------------------------===##

#  Try to get LLVM_COMPILER from HIP, then HCC2 , then default /usr/local/hip
set(HCC2 $ENV{HCC2})
if(HCC2)
  set(LLVM_COMPILER ${HCC2})
else()
  set(LLVM_COMPILER "/opt/rocm/hcc2")
endif()

# Assome rocm-device-libs repository is next to hcc2-hip repository 
set(ROCDL ${CMAKE_CURRENT_SOURCE_DIR}/../../rocm-device-libs)
set(ROCDL_INC_OCKL ${ROCDL}/ockl/inc)
set(ROCDL_INC_OCML ${ROCDL}/ocml/inc)
set(ROCDL_INC_IRIF ${ROCDL}/irif/inc)

set(libname "cudamath")
message("---> Building ${libname} with Compiler ${LLVM_COMPILER}")
project(${libname})

file(GLOB ll_sources "${CMAKE_CURRENT_SOURCE_DIR}/src/*.ll")
file(GLOB ocl_sources "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cl")

#  OpenCL files are no longer gfx specific, so only build them one time
set(cl_cmd ${LLVM_COMPILER}/bin/clang
    -S -emit-llvm
    -DCL_VERSION_2_0=200 -D__OPENCL_C_VERSION__=200
    -Dcl_khr_fp64 -Dcl_khr_fp16
    -Dcl_khr_subgroups -Dcl_khr_int64_base_atomics -Dcl_khr_int64_extended_atomics
    -x cl -Xclang -cl-std=CL2.0 -Xclang -finclude-default-header
    -target amdgcn-amd-amdhsa
    -I${ROCDL_INC_OCKL}
    -I${ROCDL_INC_OCML}
    -I${ROCDL_INC_IRIF}
    -I${CMAKE_CURRENT_SOURCE_DIR}/src
    -I${LLVM_COMPILER}/include)
set(cl_ll_files)
foreach(file ${ocl_sources})
  file(RELATIVE_PATH rfile ${CMAKE_CURRENT_SOURCE_DIR}/src ${file})
  get_filename_component(fname ${rfile} NAME_WE)
  set(ll_filename ${fname}.ll)
  add_custom_command(
    OUTPUT ${ll_filename}
    COMMAND ${cl_cmd} ${file} -o ${ll_filename} 
    DEPENDS ${file})
  list(APPEND cl_ll_files ${ll_filename})
endforeach()

#Link all llfiles from cl and ll files
add_custom_command(
    OUTPUT linkout_cudamath.bc
    COMMAND ${LLVM_COMPILER}/bin/llvm-link ${cl_ll_files} ${ll_sources} -o linkout_cudamath.bc
    DEPENDS ${cl_ll_files} ${ll_sources})
add_custom_target(linkout_cudamath-bc  ALL DEPENDS linkout_cudamath.bc)

set(final_bc_filename ${libname}.amdgcn.bc)
add_custom_command(
    OUTPUT ${final_bc_filename}
    COMMAND ${LLVM_COMPILER}/bin/prepare-builtins linkout_cudamath.bc -o ${final_bc_filename}
    DEPENDS linkout_cudamath.bc )
add_custom_target(${libname} ALL DEPENDS ${final_bc_filename})

install(FILES ${CMAKE_CURRENT_BINARY_DIR}/${final_bc_filename} DESTINATION lib)
