/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathH.h"

#if defined ENABLE_ROUNDED
#if defined HSAIL_BUILD

#define GEN(NAME,ROUND)\
CONSTATTR half \
MATH_MANGLE(NAME)(half x, half y) \
{ \
    return BUILTIN_FULL_BINARY(faddh, false, ROUND, x, y); \
}

GEN(add_rte, ROUND_TO_NEAREST_EVEN)
GEN(add_rtp, ROUND_TO_POSINF)
GEN(add_rtn, ROUND_TO_NEGINF)
GEN(add_rtz, ROUND_TO_ZERO)

#endif // HSAIL_BUILD
#endif // ENABLE_ROUNDED

