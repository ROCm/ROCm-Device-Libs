/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "ocml.h"

#define ATTR __attribute__((always_inline))

#define FUNC1(name, ocml_name, Tr, Ta) \
  ATTR Tr name(Ta x) \
  { \
    return ocml_name(x); \
  }

#define FUNC1A(name) \
  FUNC1(__hc_##name, __ocml_##name##_f32, float, float) \
  FUNC1(__hc_##name##_double, __ocml_##name##_f64, double, double)

#define FUNC1P(name) \
  FUNC1(__hc_##name, __ocml_##name##_f32, int, float) \
  FUNC1(__hc_##name##_double, __ocml_##name##_f64, int, double)

#define FUNC1B(name) \
  FUNC1(__hc_##name, __ocml_##name##_f32, float, uint) \
  FUNC1(__hc_##name##_double, __ocml_##name##_f64, double, ulong)

#define FUNC2(name, ocml_name, Tr, Ta1, Ta2) \
  ATTR Tr name(Ta1 x, Ta2 y) \
  { \
    return ocml_name(x, y); \
  }

#define FUNC2A(name) \
  FUNC2(__hc_##name, __ocml_##name##_f32, float, float, float) \
  FUNC2(__hc_##name##_double, __ocml_##name##_f64, double, double, double)

#define FUNC3(name, ocml_name, T) \
  ATTR T name(T x, T y, T z) \
  { \
    return ocml_name(x, y, z); \
  }

#define FUNC3A(name) \
  FUNC3(__hc_##name, __ocml_##name##_f32, float) \
  FUNC3(__hc_##name##_double, __ocml_##name##_f64, double)

#define FUNC4(name, ocml_name, T) \
  ATTR T name(T x, int *y) \
  { \
    int _y; \
    T r = ocml_name(x, &_y); \
    *y = _y; \
    return r; \
  }

#define FUNC4A(name) \
  FUNC4(__hc_##name, __ocml_##name##_f32, float) \
  FUNC4(__hc_##name##_double, __ocml_##name##_f64, double)

#define FUNC5(name, ocml_name, T) \
  ATTR T name(T x, T *y) \
  { \
    T _y; \
    T r = ocml_name(x, &_y); \
    *y = _y; \
    return r; \
  }

#define FUNC5A(name) \
  FUNC5(__hc_##name, __ocml_##name##_f32, float) \
  FUNC5(__hc_##name##_double, __ocml_##name##_f64, double)

#define FUNC6(name, ocml_name, T) \
  ATTR T name(T x, T y, int *z) \
  { \
    int _z; \
    T r = ocml_name(x, y, &_z); \
    *z = _z; \
    return r; \
  }

#define FUNC6A(name) \
  FUNC6(__hc_##name, __ocml_##name##_f32, float) \
  FUNC6(__hc_##name##_double, __ocml_##name##_f64, double)

FUNC1A(acos)
FUNC1A(acosh)
FUNC1A(asin)
FUNC1A(asinh)
FUNC1A(atan)
FUNC1A(atanh)
FUNC2A(atan2)
FUNC1A(cbrt)
FUNC1A(ceil)
FUNC2A(copysign)
FUNC1A(cos)
FUNC1A(cosh)
FUNC1A(cospi)
FUNC1A(erf)
FUNC1A(erfc)
FUNC1A(erfcinv)
FUNC1A(erfinv)
FUNC1A(exp)
FUNC1A(exp2)
FUNC1A(exp10)
FUNC1A(expm1)
FUNC1A(fabs)
FUNC2A(fdim)
FUNC1A(floor)
FUNC3A(fma)
FUNC2A(fmax)
FUNC2A(fmin)
FUNC2A(fmod)
FUNC4A(frexp)
FUNC2A(hypot)
FUNC1P(ilogb)
FUNC1P(isfinite)
FUNC1P(isinf)
FUNC1P(isnan)
FUNC1P(isnormal)
FUNC1A(lgamma)
FUNC1A(log)
FUNC1A(log10)
FUNC1A(log2)
FUNC1A(log1p)
FUNC1A(logb)
FUNC5A(modf)
FUNC1B(nan)
FUNC1A(nearbyint)
FUNC2A(nextafter)
FUNC2A(pow)
FUNC2A(remainder)
FUNC6A(remquo)
FUNC1A(round)
FUNC1A(rsqrt)
FUNC1A(sinpi)
FUNC2(__hc_ldexp, __ocml_ldexp_f32, float, float, int)
FUNC2(__hc_ldexp_double, __ocml_ldexp_f64, double, double, int)
FUNC1P(signbit)
FUNC1A(sin)
FUNC5A(sincos)
FUNC1A(sinh)
FUNC1A(sqrt)
FUNC1A(tgamma)
FUNC1A(tan)
FUNC1A(tanh)
FUNC1A(tanpi)
FUNC1A(trunc)

