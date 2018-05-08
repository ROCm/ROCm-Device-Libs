//===----------------------------------------------------------------------===//
//   smid.cl: amdgcn device routine
//
// This file is dual licensed under the MIT and the University of Illinois Open
// Source Licenses. See LICENSE.txt for details.
//
//===----------------------------------------------------------------------===//

extern uint __llvm_amdgcn_s_getreg(uint) __asm("llvm.amdgcn.s.getreg");

#define ATTR __attribute__((always_inline))

/*
   HW_ID Register bit structure
   WAVE_ID     3:0     Wave buffer slot number. 0-9.
   SIMD_ID     5:4     SIMD which the wave is assigned to within the CU.
   PIPE_ID     7:6     Pipeline from which the wave was dispatched.
   CU_ID       11:8    Compute Unit the wave is assigned to.
   SH_ID       12      Shader Array (within an SE) the wave is assigned to.
   SE_ID       14:13   Shader Engine the wave is assigned to.
   TG_ID       19:16   Thread-group ID
   VM_ID       23:20   Virtual Memory ID
   QUEUE_ID    26:24   Queue from which this wave was dispatched.
   STATE_ID    29:27   State ID (graphics only, not compute).
   ME_ID       31:30   Micro-engine ID.
 */

#define HW_ID               4

#define HW_ID_CU_ID_SIZE    4
#define HW_ID_CU_ID_OFFSET  8

#define HW_ID_SE_ID_SIZE    2
#define HW_ID_SE_ID_OFFSET  13

/*
   Encoding of parameter bitmask
   HW_ID        5:0     HW_ID
   OFFSET       10:6    Range: 0..31
   SIZE         15:11   Range: 1..32
 */

#define GETREG_IMMED(SZ,OFF,REG) (SZ << 11) | (OFF << 6) | REG

ATTR uint __smid(void)
{
    uint cu_id = __llvm_amdgcn_s_getreg(
            GETREG_IMMED(HW_ID_CU_ID_SIZE, HW_ID_CU_ID_OFFSET, HW_ID));
    uint se_id = __llvm_amdgcn_s_getreg(
            GETREG_IMMED(HW_ID_SE_ID_SIZE, HW_ID_SE_ID_OFFSET, HW_ID));

    /* Each shader engine has 16 CU */
    return (se_id << HW_ID_CU_ID_SIZE) + cu_id;
}

