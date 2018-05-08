//===----------------------------------------------------------------------===//
//
//  atomics.cpp  Definitions for overloade atomic opearions in hip. 
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//

// The companion to this file is x_atomics.cl which defines the non overloaded
// functions used below. 

#include "hip/hip_runtime.h"

#define __OVERL__ __attribute__((always_inline, overloadable, const)) __device__
#define __NOOVL__ extern "C" __attribute__((always_inline,const))  __device__

// atomicAdd()
// ------ support for overloaded atomicAdd ------
__NOOVL__ unsigned int x_atomicAdd_uint(unsigned int *address,
                                        unsigned int val);
__NOOVL__ int x_atomicAdd_int(int* address, int val);
__NOOVL__ float x_atomicAdd_float(float *address, float val);
__NOOVL__ unsigned long long int
x_atomicAdd_uint64(unsigned long long int *address, unsigned long long int val);

__OVERL__ unsigned int atomicAdd(unsigned int *address, unsigned int val) {
  return x_atomicAdd_uint(address, val);
}
__OVERL__ int atomicAdd(int *address, int val) {
  return x_atomicAdd_int(address, val);
}
__OVERL__ float atomicAdd(float *address, float val) {
  return x_atomicAdd_float(address, val);
}
__OVERL__ unsigned long long int atomicAdd(unsigned long long int *address,
                                           unsigned long long int val) {
  return x_atomicAdd_uint64(address, val);
}

// atomicCAS()
// ------ support for overloaded atomicCAS ------
__NOOVL__ unsigned int x_atomicCAS_uint(unsigned int *address,
                                        unsigned int compare, unsigned int val);
__NOOVL__ int x_atomicCAS_int(int* address, int compare, int val);
__NOOVL__ unsigned long long x_atomicCAS_uint64(unsigned long long *address,
                                                unsigned long long compare,
                                                unsigned long long val);
__OVERL__ unsigned int atomicCAS(unsigned int *address, unsigned int compare,
                                 unsigned int val) {
  return x_atomicCAS_uint(address, compare, val);
}
__OVERL__ int atomicCAS(int *address, int compare, int val) {
  return x_atomicCAS_int(address, compare, val);
}
__OVERL__ unsigned long long int atomicCAS(unsigned long long int *address,
                                           unsigned long long int compare,
                                           unsigned long long int val) {
  return x_atomicCAS_uint64(address, compare, val);
}

// atomicSub()
// ------ support for overloaded atomicSub ------
__NOOVL__ int x_atomicSub_int(int *address, int val);
__NOOVL__ unsigned int x_atomicSub_uint(unsigned int *address,
                                        unsigned int val);
__OVERL__ int atomicSub(int *address, int val) {
  return x_atomicSub_int(address, val);
}
__OVERL__ unsigned int atomicSub(unsigned int *address, unsigned int val) {
  return x_atomicSub_uint(address, val);
}

// atomicExch()
// ------ support for overloaded atomicExch ------
__NOOVL__ int x_atomicExch_int(int *address, int val);
__NOOVL__ unsigned int x_atomicExch_uint(unsigned int *address,
                                         unsigned int val);
__NOOVL__ unsigned long long int
x_atomicExch_uint64(unsigned long long int *address,
                    unsigned long long int val);
__NOOVL__ float x_atomicExch_float(float *address, float val);

__OVERL__ int atomicExch(int *address, int val) {
  return x_atomicExch_int(address, val);
}
__OVERL__ unsigned int atomicExch(unsigned int *address, unsigned int val) {
  return x_atomicExch_uint(address, val);
}
__OVERL__ unsigned long long int atomicExch(unsigned long long int *address,
                                            unsigned long long int val) {
  return x_atomicExch_uint64(address, val);
}
__OVERL__ float atomicExch(float *address, float val) {
  return x_atomicExch_float(address, val);
}

// atomicMin()
// ------ support for overloaded atomicExch ------
__NOOVL__ int x_atomicMin_int(int *address, int val);
__NOOVL__ unsigned int x_atomicMin_uint(unsigned int *address,
                                        unsigned int val);
__NOOVL__ unsigned long long int
x_atomicMin_uint64(unsigned long long int *address, unsigned long long int val);

__OVERL__ int atomicMin(int *address, int val) {
  return x_atomicMin_int(address, val);
}
__OVERL__ unsigned int atomicMin(unsigned int *address, unsigned int val) {
  return x_atomicMin_uint(address, val);
}
__OVERL__ unsigned long long int atomicMin(unsigned long long int *address,
                                           unsigned long long int val) {
  return x_atomicMin_uint64(address, val);
}

// atomicMax()
// ------ support for overloaded atomicMax ------
__NOOVL__ int x_atomicMax_int(int *address, int val);
__NOOVL__ unsigned int x_atomicMax_uint(unsigned int *address,
                                        unsigned int val);
__NOOVL__ unsigned long long int
x_atomicMax_uint64(unsigned long long int *address, unsigned long long int val);

__OVERL__ int atomicMax(int *address, int val) {
  return x_atomicMax_int(address, val);
}
__OVERL__ unsigned int atomicMax(unsigned int *address, unsigned int val) {
  return x_atomicMax_uint(address, val);
}
__OVERL__ unsigned long long int atomicMax(unsigned long long int *address,
                                           unsigned long long int val) {
  return x_atomicMax_uint64(address, val);
}

// atomicAnd()
// ------ support for overloaded atomicAnd ------
__NOOVL__ int x_atomicAnd_int(int *address, int val);
__NOOVL__ unsigned int x_atomicAnd_uint(unsigned int *address,
                                        unsigned int val);
__NOOVL__ unsigned long long int
x_atomicAnd_uint64(unsigned long long int *address, unsigned long long int val);

__OVERL__ int atomicAnd(int *address, int val) {
  return x_atomicAnd_int(address, val);
}
__OVERL__ unsigned int atomicAnd(unsigned int *address, unsigned int val) {
  return x_atomicAnd_uint(address, val);
}
__OVERL__ unsigned long long int atomicAnd(unsigned long long int *address,
                                           unsigned long long int val) {
  return x_atomicAnd_uint64(address, val);
}

// atomicOr()
// ------ support for overloaded atomicOr ------
__NOOVL__ int x_atomicOr_int(int *address, int val);
__NOOVL__ unsigned int x_atomicOr_uint(unsigned int *address, unsigned int val);
__NOOVL__ unsigned long long int
x_atomicOr_uint64(unsigned long long int *address, unsigned long long int val);

__OVERL__ int atomicOr(int *address, int val) {
  return x_atomicOr_int(address, val);
}
__OVERL__ unsigned int atomicOr(unsigned int *address, unsigned int val) {
  return x_atomicOr_uint(address, val);
}
__OVERL__ unsigned long long int atomicOr(unsigned long long int *address,
                                          unsigned long long int val) {
  return x_atomicOr_uint64(address, val);
}

// atomicXor()
// ------ support for overloaded atomicXOr ------
__NOOVL__ int x_atomicXor_int(int *address, int val);
__NOOVL__ unsigned int x_atomicXor_uint(unsigned int *address,
                                        unsigned int val);
__NOOVL__ unsigned long long int
x_atomicXor_uint64(unsigned long long int *address, unsigned long long int val);

__OVERL__ int atomicXor(int *address, int val) {
  return x_atomicXor_int(address, val);
}
__OVERL__ unsigned int atomicXor(unsigned int *address, unsigned int val) {
  return x_atomicXor_uint(address, val);
}
__OVERL__ unsigned long long int atomicXor(unsigned long long int *address,
                                           unsigned long long int val) {
  return x_atomicXor_uint64(address, val);
}

// atomicInc()
// ------ support for overloaded atomicInc ------
__NOOVL__ unsigned int x_atomicInc_uint(unsigned int *address,
                                        unsigned int val);
__OVERL__ unsigned int atomicInc(unsigned int *address, unsigned int val) {
  return x_atomicInc_uint(address, val);
}

// atomicDec()
// ------ support for overloaded atomicDec ------
__NOOVL__ unsigned int x_atomicDec_uint(unsigned int *address,
                                        unsigned int val);
__OVERL__ unsigned int atomicDec(unsigned int *address, unsigned int val) {
  return x_atomicDec_uint(address, val);
}
