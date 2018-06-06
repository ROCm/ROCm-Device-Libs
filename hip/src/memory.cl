unsigned __llvm_amdgcn_s_getreg(unsigned)
    __asm("llvm.amdgcn.s.getreg");

unsigned __llvm_amdgcn_groupstaticsize()
    __asm("llvm.amdgcn.groupstaticsize");

static local char* __to_local(unsigned x) {
  return (local char*)x;
}

// HCC implementation.
void *get_dynamic_group_segment_base_pointer();

void* __amdgcn_get_dynamicgroupbaseptr() {
#if 0
    // Get group segment base pointer.
    char* base = __llvm_amdgcn_s_getreg(14342) << 8);
    base += __llvm_amdgcn_groupstaticsize();
    return base;
#endif
    return get_dynamic_group_segment_base_pointer();
}