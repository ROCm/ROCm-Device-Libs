//===----------------------------------------------------------------------===//
//   clock.cl: amdgcn device routine
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//

extern ulong __llvm_amdgcn_s_memrealtime(void) __asm("llvm.amdgcn.s.memrealtime");

#define ATTR __attribute__((always_inline))

ATTR ulong __clock64(void) { return __llvm_amdgcn_s_memrealtime(); }

ATTR uint  __clock(void) { return (uint)__llvm_amdgcn_s_memrealtime(); }

