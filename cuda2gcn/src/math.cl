/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "ocml.h"

#define ATTR __attribute__((always_inline const))

#define FUNC1D(root, x) \
  ATTR double __nv_##root(double x) { return __ocml_##root##_f64(x); }
#define FUNC1F(root, x) \
  ATTR float __nv_##root##f(float x) { return __ocml_##root##_f32(x); }
#define FUNC1(root) FUNC1D(root, x) FUNC1F(root, x)

#define FUNC2D(root, x, y) \
  ATTR double __nv_##root(double x, double y) { return __ocml_##root##_f64(x, y); }
#define FUNC2F(root, x, y) \
  ATTR float __nv_##root##f(float x, float y) { return __ocml_##root##_f32(x, y); }
#define FUNC2(root) FUNC2D(root, x, y) FUNC2F(root, x, y)

#define FUNC3D(root, x, y, z) \
  ATTR double __nv_##root(double x, double y, double z) { return __ocml_##root##_f64(x, y, z); }
#define FUNC3F(root, x, y, z) \
  ATTR float __nv_##root##f(float x, float y, float z) { return __ocml_##root##_f32(x, y, z); }
#define FUNC3(root) FUNC3D(root, x, y, z) FUNC3F(root, x, y, z)

//-------- T __nv_acos
//-------- T __nv_acosf
FUNC1(acos)

//-------- T __nv_acosh
//-------- T __nv_acoshf
FUNC1(acosh)

//-------- T __nv_asin
//-------- T __nv_asinf
FUNC1(asin)

//-------- T __nv_asinh
//-------- T __nv_asinhf
FUNC1(asinh)

//-------- T __nv_atan
//-------- T __nv_atanf
FUNC1(atan)

//-------- T __nv_atan2
//-------- T __nv_atan2f
FUNC2(atan2)

//-------- T __nv_atanh
//-------- T __nv_atanhf
FUNC1(atanh)

//-------- T __nv_cbrt
//-------- T __nv_cbrtf
FUNC1(cbrt)

//-------- T __nv_ceil
//-------- T __nv_ceilf
FUNC1(ceil)

//-------- T __nv_copysign
//-------- T __nv_copysignf
FUNC2(copysign)

//-------- T __nv_cos
//-------- T __nv_cosf
FUNC1(cos)

//-------- T __nv_cosh
//-------- T __nv_coshf
FUNC1(cosh)

//-------- T __nv_cospi
//-------- T __nv_cospif
FUNC1(cospi)

//-------- T __nv_erf
//-------- T __nv_erff
FUNC1(erf)

//-------- T __nv_erfc
//-------- T __nv_erfcf
FUNC1(erfc)

//-------- T __nv_erfcinv
//-------- T __nv_erfcinvf
FUNC1(erfcinv)

//-------- T __nv_erfcx
//-------- T __nv_erfcxf
FUNC1(erfcx)

//-------- T __nv_erfinv
//-------- T __nv_erfinvf
FUNC1(erfinv)

//-------- T __nv_exp
//-------- T __nv_expf
FUNC1(exp)

//-------- T __nv_exp10
//-------- T __nv_exp10f
FUNC1(exp10)

//-------- T __nv_exp2
//-------- T __nv_exp2f
FUNC1(exp2)

//-------- T __nv_expm1
//-------- T __nv_expm1f
FUNC1(expm1)

//-------- T __nv_fabs
//-------- T __nv_fabsf
FUNC1(fabs)

//-------- T __nv_fdim
//-------- T __nv_fdimf
FUNC2(fdim)

//-------- T __nv_floor
//-------- T __nv_floorf
FUNC1(floor)

//-------- T __nv_fma
//-------- T __nv_fmaf
FUNC3(fma)

//-------- T __nv_fmod
//-------- T __nv_fmodf
FUNC2(fmod)

//-------- T __nv_hypot
//-------- T __nv_hypotf
FUNC2(hypot)

//-------- T __nv_ilogb
//-------- T __nv_ilogbf
FUNC1(ilogb)

//-------- T __nv_ldexp
//-------- T __nv_ldexpf
FUNC2(ldexp)

//-------- T __nv_lgamma
//-------- T __nv_lgammaf
FUNC1(lgamma)

//-------- T __nv_log
//-------- T __nv_logf
FUNC1(log)

//-------- T __nv_log10
//-------- T __nv_log10f
FUNC1(log10)

//-------- T __nv_log1p
//-------- T __nv_log1pf
FUNC1(log1p)

//-------- T __nv_log2
//-------- T __nv_log2f
FUNC1(log2)

//-------- T __nv_logb
//-------- T __nv_logbf
FUNC1(logb)

//-------- T __nv_pow
//-------- T __nv_powf
FUNC2(pow)

//-------- T __nv_rcbrt
//-------- T __nv_rcbrtf
FUNC1(rcbrt)

//-------- T __nv_remainder
//-------- T __nv_remainderf
FUNC2(remainder)

//-------- T __nv_nearbyint
//-------- T __nv_nearbyintf
FUNC1(nearbyint)

//-------- T __nv_nextafter
//-------- T __nv_nextafterf
FUNC2(nextafter)

//-------- T __nv_round
//-------- T __nv_roundf
FUNC1(round)

//-------- T __nv_rsqrt
//-------- T __nv_rsqrtf
FUNC1(rsqrt)

//-------- T __nv_scalbn
//-------- T __nv_scalbnf
FUNC2(scalbn)

//-------- T __nv_sin
//-------- T __nv_sinf
FUNC1(sin)

//-------- T __nv_sinh
//-------- T __nv_sinhf
FUNC1(sinh)

//-------- T __nv_sinpi
//-------- T __nv_sinpif
FUNC1(sinpi)

//-------- T __nv_sqrt
//-------- T __nv_sqrtf
FUNC1(sqrt)

//-------- T __nv_tan
//-------- T __nv_tanf
FUNC1(tan)

//-------- T __nv_tanh
//-------- T __nv_tanhf
FUNC1(tanh)

//-------- T __nv_tgamma
//-------- T __nv_tgammaf
FUNC1(tgamma)

//-------- T __nv_trunc
//-------- T __nv_truncf
FUNC1(trunc)

//-------- T __nv_abs
ATTR int __nv_abs(int x) { return abs(x); }

//-------- T __nv_llabs
ATTR long __nv_llabs(long x) { return abs(x); }

//-------- T __nv_max
ATTR int __nv_max(int a, int b) { return max(a,b); }

//-------- T __nv_fmax
ATTR double __nv_fmax(double a, double b) { return max(a,b); }

//-------- T __nv_fmaxf
ATTR float __nv_fmaxf(float a, float b) { return max(a,b); }

//-------- T __nv_llmax
ATTR long __nv_llmax(long a, long b) { return max(a,b); }

//-------- T __nv_ullmax
ATTR ulong __nv_ullmax(ulong a, ulong b) { return max(a,b); }

//-------- T __nv_umax
ATTR uint __nv_umax(uint a, uint b) { return max(a,b); }

//-------- T __nv_min
ATTR int __nv_min(int a, int b) { return min(a,b); }

//-------- T __nv_fmin
ATTR double __nv_fmin(double a, double b) { return min(a,b); }

//-------- T __nv_fminf
ATTR float __nv_fminf(float a, float b) { return min(a,b); }

//-------- T __nv_llmin
ATTR long __nv_llmin(long a, long b) { return min(a,b); }

//-------- T __nv_ullmin
ATTR ulong __nv_ullmin(ulong a, ulong b) { return min(a,b); }

//-------- T __nv_umin
ATTR uint __nv_umin(uint a, uint b) { return min(a,b); }

