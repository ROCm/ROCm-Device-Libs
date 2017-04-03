/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "irif.h"

#define ATTR __attribute__((always_inline, const))

ATTR ulong __gcn_clock64() { return __llvm_amdgcn_s_memrealtime(); }

ATTR uint  __gcn_clock() { return (uint)__llvm_amdgcn_s_memrealtime(); }



