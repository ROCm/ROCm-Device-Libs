/*===--------------------------------------------------------------------------
 *                   ROCm Device Libraries
 *
 * This file is distributed under the University of Illinois Open Source
 * License. See LICENSE.TXT for details.
 *===------------------------------------------------------------------------*/

#include "irif.h"

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

#define HW_REGISTER_ID    4

static ATTR uint get_hw_reg(uint size, uint offset, uint hw_id)
{
    /* Encoding of parameter bitmask
     * { Size[4:0], Offset[4:0], hwRegId[5:0] }
     *   Size is 1..32
     *   Offset is 0..31
     */

    uint size_bitstart = 11;
    uint offset_bitstart = 6;
    uint bit_mask = 0;
    bit_mask |= size << size_bitstart;
    bit_mask |= offset << offset_bitstart;
    bit_mask |= hw_id;

    uint reg_val = __llvm_amdgcn_s_getreg(bit_mask);

    return reg_val;
}

ATTR uint __smid()
{
    const uint cu_id_bitoffset = 8;
    const uint cu_id_bitsize = 4;
    const uint se_id_bitoffset = 13;
    const uint se_id_bitsize = 2;

    uint cu_id = get_hw_reg(cu_id_bitsize, cu_id_bitoffset, HW_REGISTER_ID);
    uint se_id = get_hw_reg(se_id_bitsize, se_id_bitoffset, HW_REGISTER_ID);

    return (se_id << cu_id_bitsize) + cu_id;
}

