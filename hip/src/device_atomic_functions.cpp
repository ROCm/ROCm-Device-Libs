//===----------------------------------------------------------------------===//
//
// device_atomic_functions.cpp: Defs for overloaded atomic opearions in hip.
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//

// The headers for these implementation are in the cuda_open headers 
// in device_atomic_functions.hpp

#ifndef __OVERL__
#define __OVERL__ __attribute__((device,always_inline, overloadable)) const
#endif

// atomicAdd()
// ------ support for overloaded atomicAdd ------
__OVERL__ unsigned atomicAdd(unsigned *address,
                                        unsigned val) {
  return atomic_add_unsigned(address, val);
}

__OVERL__ int atomicAdd(int *address, int val) {
  return atomic_add_int(address, val);
}

__OVERL__ float atomicAdd(float *address, float val) {
  return atomic_add_float(address, val);
}

__OVERL__ unsigned long long
atomicAdd(unsigned long long *address, unsigned long long val) {
  return atomic_add_uint64(address, val);
}

// atomicCAS()
// ------ support for overloaded atomicCAS ------
__OVERL__ unsigned atomicCAS(unsigned *address, unsigned compare,
                             unsigned val) {
  return atomic_compare_exchange_unsigned(address, compare, val);
}
__OVERL__ int atomicCAS(int *address, int compare, int val) {
  return atomic_compare_exchange_int(address, compare, val);
}
__OVERL__ unsigned long long atomicCAS(unsigned long long *address,
                                           unsigned long long compare,
                                           unsigned long long val) {
  return atomic_compare_exchange_uint64(address, compare, val);
}

// atomicSub()
__OVERL__ int atomicSub(int *address, int val) {
  return atomic_sub_int(address, val);
}
__OVERL__ unsigned atomicSub(unsigned *address, unsigned val) {
  return atomic_sub_unsigned(address, val);
}

// atomicExch()
// ------ support for overloaded atomicExch ------
__OVERL__ int atomicExch(int *address, int val) {
  return atomic_exchange_int(address, val);
}
__OVERL__ unsigned atomicExch(unsigned *address, unsigned val) {
  return atomic_exchange_unsigned(address, val);
}
__OVERL__ unsigned long long atomicExch(unsigned long long *address,
                                            unsigned long long val) {
  return atomic_exchange_uint64(address, val);
}
__OVERL__ float atomicExch(float *address, float val) {
  return atomic_exchange_float(address, val);
}

// atomicMin()
// ------ support for overloaded atomicExch ------
__OVERL__ int atomicMin(int *address, int val) {
  return atomic_min_int(address, val);
}
__OVERL__ unsigned atomicMin(unsigned *address, unsigned val) {
  return atomic_min_unsigned(address, val);
}
__OVERL__ unsigned long long atomicMin(unsigned long long *address,
                                           unsigned long long val) {
  return atomic_min_uint64(address, val);
}

// atomicMax()
// ------ support for overloaded atomicMax ------
__OVERL__ int atomicMax(int *address, int val) {
  return atomic_max_int(address, val);
}
__OVERL__ unsigned atomicMax(unsigned *address, unsigned val) {
  return atomic_max_unsigned(address, val);
}
__OVERL__ unsigned long long atomicMax(unsigned long long *address,
                                           unsigned long long val) {
  return atomic_max_uint64(address, val);
}

// atomicAnd()
// ------ support for overloaded atomicAnd ------
__OVERL__ int atomicAnd(int *address, int val) {
  return atomic_and_int(address, val);
}
__OVERL__ unsigned atomicAnd(unsigned *address, unsigned val) {
  return atomic_and_unsigned(address, val);
}
__OVERL__ unsigned long long atomicAnd(unsigned long long *address,
                                           unsigned long long val) {
  return atomic_and_uint64(address, val);
}

// atomicOr()
// ------ support for overloaded atomicOr ------
__OVERL__ int atomicOr(int *address, int val) {
  return atomic_or_int(address, val);
}
__OVERL__ unsigned atomicOr(unsigned *address, unsigned val) {
  return atomic_or_unsigned(address, val);
}
__OVERL__ unsigned long long atomicOr(unsigned long long *address,
                                          unsigned long long val) {
  return atomic_or_uint64(address, val);
}

// atomicXor()
// ------ support for overloaded atomicXOr ------
__OVERL__ int atomicXor(int *address, int val) {
  return atomic_xor_int(address, val);
}
__OVERL__ unsigned atomicXor(unsigned *address, unsigned val) {
  return atomic_xor_unsigned(address, val);
}
__OVERL__ unsigned long long atomicXor(unsigned long long *address,
                                           unsigned long long val) {
  return atomic_xor_uint64(address, val);
}

// atomicInc()
// ------ support for overloaded atomicInc ------
__OVERL__ unsigned atomicInc(unsigned *address) {
  return atomic_inc_unsigned(address);
}
__OVERL__ unsigned atomicInc(unsigned *address, unsigned max) {
  if (*address>=max)
    return *address;
  else
    return atomic_inc_unsigned(address);
}
__OVERL__ int atomicInc(int *address) {
  return atomic_inc_int(address);
}

// atomicDec()
// ------ support for overloaded atomicDec ------
__OVERL__ unsigned atomicDec(unsigned *address) {
  return atomic_dec_unsigned(address);
}
__OVERL__ int atomicDec(int *address) {
  return atomic_dec_int(address);
}

