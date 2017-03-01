/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "mathH.h"

INLINEATTR half
MATH_MANGLE(lgamma_r)(half x, int *signp)
{
    return (half)MATH_UPMANGLE(lgamma_r)((float)x, signp);
}

