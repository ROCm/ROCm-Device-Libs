/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathF.h"

CONSTATTR float
MATH_MANGLE(hypot)(float x, float y)
{
    float a = BUILTIN_ABS_F32(x);
    float b = BUILTIN_ABS_F32(y);
    float t = AS_FLOAT(BUILTIN_MAX_U32(AS_UINT(a), AS_UINT(b)));
    int e = BUILTIN_FREXP_EXP_F32(t) ;
    a = BUILTIN_FLDEXP_F32(a, -e);
    b = BUILTIN_FLDEXP_F32(b, -e);
    float ret = BUILTIN_FLDEXP_F32(MATH_FAST_SQRT(MATH_MAD(a, a, b*b)), e);

    if (!FINITE_ONLY_OPT()) {
        ret = (BUILTIN_CLASS_F32(x, CLASS_PINF|CLASS_NINF) |
               BUILTIN_CLASS_F32(y, CLASS_PINF|CLASS_NINF)) ?
              AS_FLOAT(PINFBITPATT_SP32) : ret;
    }

    return ret;
}

