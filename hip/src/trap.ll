; ModuleID = 'trap.bc'

source_filename = "trap.ll"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5"
target triple = "amdgcn-amd-amdhsa"

; Function Attrs: alwaysinline noreturn nounwind
define void @__device_trap() #0 {
  tail call void @llvm.trap()
    ret void
}

declare void @llvm.trap() noreturn nounwind

attributes #0 = { alwaysinline noreturn nounwind }

