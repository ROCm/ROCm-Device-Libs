/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "irif.h"

#define ATTR __attribute__((always_inline, const))

#define REGISTER   4
#define MASK      15

// cu id in amdgcn

ATTR int __smid()
{
    return __llvm_amdgcn_s_getreg(REGISTER) >> 8 & MASK;
}

