/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathD.h"

typedef struct fract_ret_ty
{
    double f;
    double i;
} fract_ret_ty;

static fract_ret_ty _fract_impl(double x)
{
    double i = BUILTIN_FLOOR_F64(x);

    double f;
    if (__oclc_ISA_version() < 800) {
        f = BUILTIN_MIN_F64(x - i, 0x1.fffffffffffffp-1);
        if (!FINITE_ONLY_OPT()) {
            f = BUILTIN_CLASS_F64(x, CLASS_QNAN|CLASS_SNAN) ? x : f;
            f = BUILTIN_CLASS_F64(x, CLASS_PINF|CLASS_NINF) ? 0.0 : f;
        }
    } else {
        f = BUILTIN_FRACTION_F64(x);
    }

    fract_ret_ty ret = { f, i };
    return ret;
}

double
MATH_MANGLE(fract)(double x, __private double *ip)
{
    fract_ret_ty ret = _fract_impl(x);

    *ip = ret.i;
    return ret.f;
}

