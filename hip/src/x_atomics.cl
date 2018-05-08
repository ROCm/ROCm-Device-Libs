//===----------------------------------------------------------------------===//
//  x_atomics.cl  eXplicit, not overloaded atomic definitions
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//

// The companion to this file is atomics.cpp which implements 
// the overloaded atomic operators for hip. 

#define INLINE __attribute__((always_inline,const)) 


// atomicAdd =
// These are defined in rocm device lib in hc_atomic.ll
// define i32 @atomic_add_unsigned_global(i32 addrspace(1)* %x, i32 %y) 
// define i32 @atomic_add_unsigned_local(i32 addrspace(3)* %x, i32 %y) 
// define i32 @atomic_add_unsigned_local(i32 addrspace(3)* %x, i32 %y)
// define i32 @atomic_add_unsigned(i32 addrspace(4)* %x, i32 %y)
// define i32 @atomic_add_int_global(i32 addrspace(1)* %x, i32 %y)
// define i32 @atomic_add_int_local(i32 addrspace(3)* %x, i32 %y)
// define i32 @atomic_add_int(i32 addrspace(4)* %x, i32 %y)
// define float @atomic_add_float_global(float addrspace(1)* %x, float %y)
// define float @atomic_add_float_local(float addrspace(3)* %x, float %y)
// define float @atomic_add_float(float addrspace(4)* %x, float %y)
// define i64 @atomic_add_uint64_global(i64 addrspace(1)* %x, i64 %y)
// define i64 @atomic_add_uint64_local(i64 addrspace(3)* %x, i64 %y)
// define i64 @atomic_add_uint64(i64 addrspace(4)* %x, i64 %y)

// no header for hc_atomics.ll, so declare them here for OpenCL
uint atomic_add_unsigned_global(__global atomic_uint * x, uint y);
int atomic_add_int_global(__global atomic_int * x, int y);
float atomic_add_float_global(__global atomic_float * x, float y);

// Define functions used used to implement overloaded atomicAdd
INLINE uint x_atomicAdd_uint(uint * x, uint y) {
  //define i32 @atomic_add_unsigned_global(i32 addrspace(1)* %x, i32 %y) 
  return atomic_add_unsigned_global((__global atomic_uint *) x,y);
}
INLINE int x_atomicAdd_int(int * x, int y) {
  //define i32 @atomic_add_int_global(i32 addrspace(1)* %x, i32 %y)
  return atomic_add_int_global((__global atomic_int *) x,y);
}
INLINE float x_atomicAdd_float(float * x, float y) {
  //define float @atomic_add_float_global(float addrspace(1)* %x, float %y)
  return atomic_add_float_global((__global atomic_float *) x,y);
}


// atomicCAS -
// These are defined in rocm device lib in hc_atomic.ll
// define i32 @atomic_compare_exchange_unsigned_global(i32 addrspace(1)* %x, i32 %y, i32 %z)
// define i32 @atomic_compare_exchange_unsigned_local(i32 addrspace(3)* %x, i32 %y, i32 %z)
// define i32 @atomic_compare_exchange_unsigned(i32 addrspace(4)* %x, i32 %y, i32 %z) 
// define i32 @atomic_compare_exchange_int_global(i32 addrspace(1)* %x, i32 %y, i32 %z)
// define i32 @atomic_compare_exchange_int_local(i32 addrspace(3)* %x, i32 %y, i32 %z)
// define i32 @atomic_compare_exchange_int(i32 addrspace(4)* %x, i32 %y, i32 %z)
// define i64 @atomic_compare_exchange_uint64_global(i64 addrspace(1)* %x, i64 %y, i64 %z)
// define i64 @atomic_compare_exchange_uint64_local(i64 addrspace(3)* %x, i64 %y, i64 %z)
// define i64 @atomic_compare_exchange_uint64(i64 addrspace(4)* %x, i64 %y, i64 %z)

// no header for hc_atomics.ll, so declare them here for OpenCL
uint atomic_compare_exchange_unsigned_global(__global atomic_uint * x, uint y, uint z);
int atomic_compare_exchange_int_global(__global atomic_int * x, int y, int z);

INLINE uint x_atomicCAS_uint(uint * x, uint y, uint z){
  // define i32 @atomic_compare_exchange_unsigned_global(i32 addrspace(1)* %x, i32 %y, i32 %z) #2 {
  return atomic_compare_exchange_unsigned_global((__global atomic_uint *) x,y,z);
}
INLINE int x_atomicCAS_int(int * x, int y, int z){
  // define i32 @atomic_compare_exchange_int_global(i32 addrspace(1)* %x, i32 %y, i32 %z) #2 {
  return atomic_compare_exchange_int_global((__global atomic_int *) x,y,z);
}

// FIXME: Add long long support and other atomics
