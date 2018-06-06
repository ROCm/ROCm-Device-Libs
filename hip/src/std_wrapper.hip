/*
 * std_wrapper.hip
 *
 *  Created on: May 29, 2018
 *      Author: yaxunl
 */


#include "hip_minimal.h"

#define __DEVICE__ __device__ __forceinline__
#define D(T, f) \
__DEVICE__ T f(T x);\
namespace std {\
  __DEVICE__ T f(T x) {\
    return ::f(x);\
  }\
}

D(float, exp)
