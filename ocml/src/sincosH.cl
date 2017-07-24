/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathH.h"
#include "trigredH.h"

half2
MATH_MANGLE2(sincos)(half2 x, __private half2 *cp)
{
    half2 s;
    half clo, chi;
    s.lo = MATH_MANGLE(sincos)(x.lo, &clo);
    s.hi = MATH_MANGLE(sincos)(x.hi, &chi);
    *cp = (half2)(clo, chi);
    return s;
}

half
MATH_MANGLE(sincos)(half x, __private half *cp)
{
    half r;
    short regn = MATH_PRIVATE(trigred)(&r, BUILTIN_ABS_F16(x));

    half cc;
    half ss = MATH_PRIVATE(sincosred)(r, &cc);

    short flip = regn > (short)1 ? (short)0x8000 : (short)0;
    bool odd = (regn & 1) != 0;
    short s = AS_SHORT(odd ? cc : ss);
    s ^= flip ^ (AS_SHORT(x) & (short)0x8000);
    ss = -ss;
    short c = AS_SHORT(odd ? ss : cc);
    c ^= flip;

    if (!FINITE_ONLY_OPT()) {
        bool nori = BUILTIN_CLASS_F16(x, CLASS_SNAN|CLASS_QNAN|CLASS_NINF|CLASS_PINF);
        c = nori ? (short)QNANBITPATT_HP16 : c;
        s = nori ? (short)QNANBITPATT_HP16 : s;
    }

    *cp = AS_HALF(c);
    return AS_HALF(s);
}

