/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathH.h"

PUREATTR UGEN(erfcinv)

PUREATTR half
MATH_MANGLE(erfcinv)(half x)
{
    return (half)MATH_UPMANGLE(erfcinv)((float)x);
}

