#include "ockl.h"
#include "irif.h"

#define ATTR2 __attribute__((always_inline))
static ATTR2 void
hc_work_group_barrier(cl_mem_fence_flags flags, memory_scope scope)
{
    if (flags) {
        atomic_work_item_fence(flags, memory_order_release, scope);
        __builtin_amdgcn_s_barrier();
        atomic_work_item_fence(flags, memory_order_acquire, scope);
    } else {
        __builtin_amdgcn_s_barrier();
    }
}

static ATTR2 void
hc_barrier(int n)
{
  hc_work_group_barrier((cl_mem_fence_flags)n, memory_scope_work_group);
}

ATTR2 void __syncthreads() {
  hc_barrier(CLK_LOCAL_MEM_FENCE);
}
