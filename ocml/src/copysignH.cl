/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathH.h"

ALWAYS_INLINE CONSTATTR half2
MATH_MANGLE2(copysign)(half2 x, half2 y)
{
    return BUILTIN_COPYSIGN_2F16(x, y);
}

ALWAYS_INLINE CONSTATTR half
MATH_MANGLE(copysign)(half x, half y)
{
    return BUILTIN_COPYSIGN_F16(x, y);
}

