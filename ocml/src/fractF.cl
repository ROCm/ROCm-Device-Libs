/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathF.h"

typedef struct fract_ret_ty
{
    float f;
    float i;
} fract_ret_ty;

static fract_ret_ty _fract_impl(float x)
{
    float i = BUILTIN_FLOOR_F32(x);

    float f;
    if (__oclc_ISA_version() < 800) {
        f = BUILTIN_MIN_F32(x - i, 0x1.fffffep-1f);
        if (!FINITE_ONLY_OPT()) {
            f = BUILTIN_CLASS_F32(x, CLASS_QNAN|CLASS_SNAN) ? x : f;
            f = BUILTIN_CLASS_F32(x, CLASS_PINF|CLASS_NINF) ? 0.0f : f;
        }
    } else {
        f = BUILTIN_FRACTION_F32(x);
    }

    fract_ret_ty ret = { f, i };
    return ret;
}

ALWAYS_INLINE float
MATH_MANGLE(fract)(float x, __private float *ip)
{
    fract_ret_ty ret = _fract_impl(x);

    *ip = ret.i;
    return ret.f;
}

