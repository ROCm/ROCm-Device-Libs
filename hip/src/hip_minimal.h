/*
 * hip_minimal.h
 *
 * A minimal HIP header file for device lib.
 * 
 * We should not let device lib depend on HIP runtime.
 * 
 */

#ifndef HIP_MINIMAL_H_
#define HIP_MINIMAL_H_

#if defined(__clang__) && defined(__HIP__)

#define __host__ __attribute__((host))
#define __device__ __attribute__((device))
#define __global__ __attribute__((global))
#define __shared__ __attribute__((shared))
#define __constant__ __attribute__((constant))

#define __noinline__ __attribute__((noinline))
#define __forceinline__ __attribute__((always_inline))

typedef unsigned uint;
typedef unsigned long size_t;

#define __OVERL__ __attribute__((always_inline, overloadable, const)) __device__
#define __NOOVL__ extern "C" __attribute__((always_inline,const))  __device__

__OVERL__ unsigned int atomicAdd(unsigned int *address, unsigned int val);
__OVERL__ int atomicAdd(int *address, int val);
__OVERL__ float atomicAdd(float *address, float val);
__OVERL__ unsigned long long int atomicAdd(unsigned long long int *address,
                                           unsigned long long int val);

__OVERL__ unsigned int atomicCAS(unsigned int *address, unsigned int compare,
                                 unsigned int val);
__OVERL__ int atomicCAS(int *address, int compare, int val);
__OVERL__ unsigned long long int atomicCAS(unsigned long long int *address,
                                           unsigned long long int compare,
                                           unsigned long long int val);

#undef __OVERL__
#undef __NOOVL__
#endif



#endif /* HIP_MINIMAL_H_ */
