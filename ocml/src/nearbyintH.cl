/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathH.h"

ALWAYS_INLINE CONSTATTR half2
MATH_MANGLE2(nearbyint)(half2 x)
{
    return BUILTIN_RINT_2F16(x);
}

ALWAYS_INLINE CONSTATTR half
MATH_MANGLE(nearbyint)(half x)
{
    return BUILTIN_RINT_F16(x);
}

