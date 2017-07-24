/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathF.h"

#if defined ENABLE_ROUNDED
#if defined HSAIL_BUILD

#define GEN(NAME,ROUND)\
CONSTATTR float \
MATH_MANGLE(NAME)(float x, float y) \
{ \
    float ret; \
    if (DAZ_OPT()) { \
        ret = BUILTIN_FULL_BINARY(fmulf, true, ROUND, x, y); \
    } else { \
        ret = BUILTIN_FULL_BINARY(fmulf, false, ROUND, x, y); \
    } \
    return ret; \
}

GEN(mul_rte, ROUND_TO_NEAREST_EVEN)
GEN(mul_rtp, ROUND_TO_POSINF)
GEN(mul_rtn, ROUND_TO_NEGINF)
GEN(mul_rtz, ROUND_TO_ZERO)

#endif // HSAIL_BUILD
#endif // ENABLE_ROUNDED

