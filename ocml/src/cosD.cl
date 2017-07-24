/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathD.h"
#include "trigredD.h"

double
MATH_MANGLE(cos)(double x)
{
    double r, rr;
    int regn = MATH_PRIVATE(trigred)(&r, &rr, BUILTIN_ABS_F64(x));

    double cc;
    double ss = -MATH_PRIVATE(sincosred2)(r, rr, &cc);

    int2 c = AS_INT2((regn & 1) != 0 ? ss : cc);
    c.hi ^= regn > 1 ? (int)0x80000000 : 0;

    if (!FINITE_ONLY_OPT()) {
        c = BUILTIN_CLASS_F64(x, CLASS_SNAN|CLASS_QNAN|CLASS_NINF|CLASS_PINF) ? AS_INT2(QNANBITPATT_DP64) : c;
    }

    return AS_DOUBLE(c);
}

