;/*===--------------------------------------------------------------------------
; *                   ROCm Device Libraries
; *
; * This file is distributed under the University of Illinois Open Source
; * License. See LICENSE.TXT for details.
; *===------------------------------------------------------------------------*/

; ModuleID = 'barrier_wrapper.bc'
source_filename = "barrier_wrapper.ll"
target datalayout = "e-p:64:64-p1:64:64-p2:64:64-p3:32:32-p4:64:64-p5:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn--amdhsa"

; Function Attrs: convergent nounwind
declare void @llvm.amdgcn.s.barrier() #0

; Function Attrs: alwaysinline nounwind
define void @named_sync(i32,i32) local_unnamed_addr #1 {
  tail call void @llvm.amdgcn.s.barrier() #0
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @nvvm.barrier0() local_unnamed_addr #1 {
  tail call void @llvm.amdgcn.s.barrier() #0
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @nvvm.barrier1(i32,i32) local_unnamed_addr #1 {
  tail call void @llvm.amdgcn.s.barrier() #0
  ret void
}

attributes #0 = { convergent nounwind }
attributes #1 = { alwaysinline nounwind }


