/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathF.h"
#include "trigredF.h"

INLINEATTR float
MATH_MANGLE(sincos)(float x, __private float *cp)
{
    int ix = AS_INT(x);
    int ax = ix & 0x7fffffff;

#if defined EXTRA_PRECISION
    float r0, r1;
    int regn = MATH_PRIVATE(trigred)(&r0, &r1, AS_FLOAT(ax));

    float cc;
    float ss = MATH_PRIVATE(sincosred2)(r0, r1, &cc);
#else
    float r;
    int regn = MATH_PRIVATE(trigred)(&r, AS_FLOAT(ax));

    float cc;
    float ss = MATH_PRIVATE(sincosred)(r, &cc);
#endif

    int flip = regn > 1 ? 0x80000000 : 0;
    bool odd = (regn & 1) != 0;
    float s = odd ? cc : ss;
    s = AS_FLOAT(AS_INT(s) ^ flip ^ (ax ^ ix));
    ss = -ss;
    float c = odd ? ss : cc;
    c = AS_FLOAT(AS_INT(c) ^ flip);

    if (!FINITE_ONLY_OPT()) {
        c = ax >= PINFBITPATT_SP32 ? AS_FLOAT(QNANBITPATT_SP32) : c;
        s = ax >= PINFBITPATT_SP32 ? AS_FLOAT(QNANBITPATT_SP32) : s;
    }

    *cp = c;
    return s;
}

