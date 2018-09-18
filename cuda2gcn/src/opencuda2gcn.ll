;;
source_filename = "hipAutomaticMode.ll"
target datalayout = "e-p:64:64-p1:64:64-p2:32:32-p3:32:32-p4:64:64-p5:32:32-p6:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64-S32-A5"
target triple = "amdgcn-amd-amdhsa"

declare i32 @llvm.amdgcn.s.getreg(i32) #0

declare i64 @llvm.amdgcn.s.memrealtime() #6

; Function Attrs: nounwind readnone
declare i8 addrspace(2)* @llvm.amdgcn.dispatch.ptr() #0

; Function Attrs: nounwind readnone
declare i32 @llvm.amdgcn.workgroup.id.x() #0

; Function Attrs: nounwind readnone
declare i32 @llvm.amdgcn.workgroup.id.y() #0

; Function Attrs: nounwind readnone
declare i32 @llvm.amdgcn.workgroup.id.z() #0

; Function Attrs: nounwind readnone
declare i32 @llvm.amdgcn.workitem.id.x() #0

; Function Attrs: nounwind readnone
declare i32 @llvm.amdgcn.workitem.id.y() #0

; Function Attrs: nounwind readnone
declare i32 @llvm.amdgcn.workitem.id.z() #0

; Function Attrs: convergent nounwind
declare void @llvm.amdgcn.s.barrier() #1

; Function Attrs: nounwind readnone
declare i32 @llvm.ctpop.i32(i32) #1

; Function Attrs: nounwind readnone
declare i64 @llvm.ctpop.i64(i64) #1

; Function Attrs: nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1) #1

; Function Attrs: nounwind readnone
declare i64 @llvm.ctlz.i64(i64, i1) #1

; Function Attrs: alwaysinline nounwind readnone
declare i64 @__ockl_get_local_size(i32) local_unnamed_addr #6

; Function Attrs: alwaysinline nounwind readnone
declare i64 @__ockl_get_num_groups(i32) local_unnamed_addr #6

; ptx ntid.x is same as trunk get_local_size(0)
; Function Attrs: alwaysinline
define i32 @nvvm.read.ptx.sreg.ntid.x() #2 {
  %call = tail call i64 @__ockl_get_local_size(i32 0) #6
  %1 = trunc i64 %call to i32
  ret i32 %1
;  Test and revert to this code if possible.
; %dispatch_ptr = call noalias nonnull dereferenceable(64) i8 addrspace(2)* @llvm.amdgcn.dispatch.ptr()
; %dispatch_ptr_i32 = bitcast i8 addrspace(2)* %dispatch_ptr to i32 addrspace(2)*
; %size_xy_ptr = getelementptr inbounds i32, i32 addrspace(2)* %dispatch_ptr_i32, i64 1
; %size_xy = load i32, i32 addrspace(2)* %size_xy_ptr, align 4, !invariant.load !0
; %1 = and i32 %size_xy, 65535
; ret i32 %1
}

; Function Attrs: alwaysinline
define i32 @nvvm.read.ptx.sreg.ntid.y() #2 {
  %call = tail call i64 @__ockl_get_local_size(i32 1) #6
  %1 = trunc i64 %call to i32
  ret i32 %1
}

; Function Attrs: alwaysinline
define i32 @nvvm.read.ptx.sreg.ntid.z() #2 {
  %call = tail call i64 @__ockl_get_local_size(i32 2) #6
  %1 = trunc i64 %call to i32
  ret i32 %1
}

; This is the same as trunc get_num_groups(0) 
; Function Attrs: alwaysinline nounwind
define i32 @nvvm.read.ptx.sreg.nctaid.x() #3 {
  %call = tail call i64 @__ockl_get_num_groups(i32 0) #6
  %1 = trunc i64 %call to i32
  ret i32 %1
;  Test and revert to this code if possible.
;  %1 = tail call i8 addrspace(2)* @llvm.amdgcn.dispatch.ptr() #0
;  %2 = getelementptr inbounds i8, i8 addrspace(2)* %1, i64 12
;  %3 = bitcast i8 addrspace(2)* %2 to i32 addrspace(2)*
;  %4 = load i32, i32 addrspace(2)* %3, align 4, !tbaa !1
;  %5 = getelementptr inbounds i8, i8 addrspace(2)* %1, i64 4
;  %6 = bitcast i8 addrspace(2)* %5 to i16 addrspace(2)*
;  %7 = load i16, i16 addrspace(2)* %6, align 4, !tbaa !10
;  %8 = zext i16 %7 to i32
;  %9 = udiv i32 %4, %8
;  %10 = mul i32 %9, %8
;  %11 = icmp ugt i32 %4, %10
;  %12 = zext i1 %11 to i32
;  %13 = add i32 %12, %9
;  ret i32 %13
}

; Function Attrs: alwaysinline nounwind
define i32 @nvvm.read.ptx.sreg.nctaid.y() #3 {
  %call = tail call i64 @__ockl_get_num_groups(i32 1) #6
  %1 = trunc i64 %call to i32
  ret i32 %1
}

; Function Attrs: alwaysinline nounwind
define i32 @nvvm.read.ptx.sreg.nctaid.z() #3 {
  %call = tail call i64 @__ockl_get_num_groups(i32 2) #6
  %1 = trunc i64 %call to i32
  ret i32 %1
}

; Function Attrs: alwaysinline nounwind
define i32 @nvvm.read.ptx.sreg.warpsize() #3 {
  ret i32 64
}

; Function Attrs: alwaysinline norecurse nounwind readnone 
define i32 @nvvm.read.ptx.sreg.tid.x() #4 {
  %id = tail call i32 @llvm.amdgcn.workitem.id.x()
  ret i32 %id
}

; Function Attrs: alwaysinline norecurse nounwind readnone 
define i32 @nvvm.read.ptx.sreg.ctaid.x() #4 {
  %id = tail call i32 @llvm.amdgcn.workgroup.id.x()
  ret i32 %id
}

; Function Attrs: alwaysinline norecurse nounwind readnone 
define i32 @nvvm.read.ptx.sreg.tid.y() #4 {
  %id = tail call i32 @llvm.amdgcn.workitem.id.y()
  ret i32 %id
}

; Function Attrs: alwaysinline norecurse nounwind readnone 
define i32 @nvvm.read.ptx.sreg.ctaid.y() #4 {
  %id = tail call i32 @llvm.amdgcn.workgroup.id.y()
  ret i32 %id
}
; Function Attrs: alwaysinline norecurse nounwind readnone 
define i32 @nvvm.read.ptx.sreg.tid.z() #4 {
  %id = tail call i32 @llvm.amdgcn.workitem.id.z()
  ret i32 %id
}

; Function Attrs: alwaysinline norecurse nounwind readnone 
define i32 @nvvm.read.ptx.sreg.ctaid.z() #4 {
  %id = tail call i32 @llvm.amdgcn.workgroup.id.z()
  ret i32 %id
}

; Function Attrs: alwaysinline nounwind
define void @nvvm.barrier0() local_unnamed_addr #3 {
  tail call void @llvm.amdgcn.s.barrier() #1
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @nvvm.barrier1(i32,i32) local_unnamed_addr #3 {
  tail call void @llvm.amdgcn.s.barrier() #1
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @llvm_amdgcn_s_barrier() local_unnamed_addr #3 {
  tail call void @llvm.amdgcn.s.barrier() #1
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @nvvm.barrier(i32, i32) local_unnamed_addr #3 {
  tail call void @llvm.amdgcn.s.barrier() #1
  ret void
}

; Function Attrs: alwaysinline nounwind
define i32 @nvvm.popc.i(i32 %a) local_unnamed_addr #3 {
  %b = tail call i32 @llvm.ctpop.i32(i32 %a)
  ret i32 %b
}

; Function Attrs: alwaysinline nounwind
define i32 @nvvm.popc.ll(i64 %a) local_unnamed_addr #3{
  %b = tail call i64 @llvm.ctpop.i64(i64 %a)
  %c = trunc i64 %b to i32
  ret i32 %c
}

; Function Attrs: alwaysinline nounwind
define i32 @nvvm.clz.i(i32 %a) #3 {
  %b = tail call i32 @llvm.ctlz.i32(i32 %a, i1 false)
  ret i32 %b
}

; Function Attrs: alwaysinline nounwind
define i32 @nvvm.clz.ll(i64 %a) #3 {
  %b = tail call i64 @llvm.ctlz.i64(i64 %a, i1 false)
  %c = trunc i64 %b to i32
  ret i32 %c
}

; Function Attrs: alwaysinline nounwind
define void @nvvm.membar.cta() #3 {
  fence syncscope("workgroup") seq_cst
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @nvvm.membar.gl() #3 {
  fence syncscope("agent") seq_cst
  ret void
}

; Function Attrs: alwaysinline nounwind
define void @nvvm.membar.sys() #3 {
  fence seq_cst
  ret void
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; atomic

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define float @nvvm.atomic.load.add.f32.p0f32(float* %address, float %val) {
  %oldi.addr = alloca i32, align 4 , addrspace(5)
  %vali = bitcast float %val to i32
  %cast = bitcast float* %address to i32*
  %oldi = atomicrmw volatile add i32* %cast, i32 %vali monotonic, !mem.scope !12
  store i32 %oldi, i32 addrspace(5)* %oldi.addr, align 4
  %oldf.addr = bitcast i32 addrspace(5)* %oldi.addr to float addrspace(5)*
  %old = load float, float addrspace(5)* %oldf.addr, align 4
  ret float %old
}

define float @nvvm.atomic.load.add.f32.p1f32(float addrspace(1)* %address, float %val) {
  %oldi.addr = alloca i32, align 4 , addrspace(5)
  %vali = bitcast float %val to i32
  %cast = bitcast float addrspace(1)* %address to i32 addrspace(1)*
  %oldi = atomicrmw volatile add i32 addrspace(1)* %cast, i32 %vali monotonic, !mem.scope !12
  store i32 %oldi, i32 addrspace(5)* %oldi.addr, align 4
  %oldf.addr = bitcast i32 addrspace(5)* %oldi.addr to float addrspace(5)*
  %old = load float, float addrspace(5)* %oldf.addr, align 4
  ret float %old
}

define float @nvvm.atomic.load.add.f32.p3f32(float addrspace(3)* %address, float %val) {
  %oldi.addr = alloca i32, align 4, addrspace(5)
  %vali = bitcast float %val to i32
  %cast = bitcast float addrspace(3)* %address to i32 addrspace(3)*
  %oldi = atomicrmw volatile add i32 addrspace(3)* %cast, i32 %vali monotonic, !mem.scope !12
  store i32 %oldi, i32 addrspace(5)* %oldi.addr, align 4
  %oldf.addr = bitcast i32 addrspace(5)* %oldi.addr to float addrspace(5)*
  %old = load float, float addrspace(5)* %oldf.addr, align 4
  ret float %old
}

define i32 @nvvm.atomic.load.inc.32.p0i32(i32*, i32) {
  %3 = load i32, i32* %0, align 4
  br label %4

; <label>:4:                                      ; preds = %4, %2
  %5 = phi i32 [ %3, %2 ], [ %10, %4 ]
  %6 = icmp sge i32 %5, %1
  %7 = add nsw i32 %5, 1
  %8 = select i1 %6, i32 0, i32 %7
  %9 = cmpxchg i32* %0, i32 %5, i32 %8 seq_cst seq_cst, !mem.scope !12
  %10 = extractvalue { i32, i1 } %9, 0
  %11 = icmp eq i32 %5, %10
  br i1 %11, label %12, label %4

; <label>:12:                                     ; preds = %4
  ret i32 %5
}

define i32 @nvvm.atomic.load.inc.32.p1i32(i32 addrspace(1)*, i32) {
  %3 = load i32, i32 addrspace(1)* %0, align 4
  br label %4

; <label>:4:                                      ; preds = %4, %2
  %5 = phi i32 [ %3, %2 ], [ %10, %4 ]
  %6 = icmp sge i32 %5, %1
  %7 = add nsw i32 %5, 1
  %8 = select i1 %6, i32 0, i32 %7
  %9 = cmpxchg i32 addrspace(1)* %0, i32 %5, i32 %8 seq_cst seq_cst, !mem.scope !12
  %10 = extractvalue { i32, i1 } %9, 0
  %11 = icmp eq i32 %5, %10
  br i1 %11, label %12, label %4

; <label>:12:                                     ; preds = %4
  ret i32 %5
}

define i32 @nvvm.atomic.load.inc.32.p3i32(i32 addrspace(3)*, i32) {
  %3 = load i32, i32 addrspace(3)* %0, align 4
  br label %4

; <label>:4:                                      ; preds = %4, %2
  %5 = phi i32 [ %3, %2 ], [ %10, %4 ]
  %6 = icmp sge i32 %5, %1
  %7 = add nsw i32 %5, 1
  %8 = select i1 %6, i32 0, i32 %7
  %9 = cmpxchg i32 addrspace(3)* %0, i32 %5, i32 %8 seq_cst seq_cst, !mem.scope !12
  %10 = extractvalue { i32, i1 } %9, 0
  %11 = icmp eq i32 %5, %10
  br i1 %11, label %12, label %4

; <label>:12:                                     ; preds = %4
  ret i32 %5
}

define i32 @nvvm.atomic.load.dec.32.p0i32(i32*, i32) {
  %3 = load i32, i32* %0, align 4
  br label %4

; <label>:4:                                      ; preds = %4, %2
  %5 = phi i32 [ %3, %2 ], [ %12, %4 ]
  %6 = icmp eq i32 %5, 0
  %7 = icmp sgt i32 %5, %1
  %8 = or i1 %6, %7
  %9 = add nsw i32 %5, -1
  %10 = select i1 %8, i32 %1, i32 %9
  %11 = cmpxchg i32* %0, i32 %5, i32 %10 seq_cst seq_cst, !mem.scope !12
  %12 = extractvalue { i32, i1 } %11, 0
  %13 = icmp eq i32 %5, %12
  br i1 %13, label %14, label %4

; <label>:14:                                     ; preds = %4
  ret i32 %5
}

define i32 @nvvm.atomic.load.dec.32.p1i32(i32 addrspace(1)*, i32) {
  %3 = load i32, i32 addrspace(1)* %0, align 4
  br label %4

; <label>:4:                                      ; preds = %4, %2
  %5 = phi i32 [ %3, %2 ], [ %12, %4 ]
  %6 = icmp eq i32 %5, 0
  %7 = icmp sgt i32 %5, %1
  %8 = or i1 %6, %7
  %9 = add nsw i32 %5, -1
  %10 = select i1 %8, i32 %1, i32 %9
  %11 = cmpxchg i32 addrspace(1)* %0, i32 %5, i32 %10 seq_cst seq_cst, !mem.scope !12
  %12 = extractvalue { i32, i1 } %11, 0
  %13 = icmp eq i32 %5, %12
  br i1 %13, label %14, label %4

; <label>:14:                                     ; preds = %4
  ret i32 %5
}

define i32 @nvvm.atomic.load.dec.32.p3i32(i32 addrspace(3)*, i32) {
  %3 = load i32, i32 addrspace(3)* %0, align 4
  br label %4

; <label>:4:                                      ; preds = %4, %2
  %5 = phi i32 [ %3, %2 ], [ %12, %4 ]
  %6 = icmp eq i32 %5, 0
  %7 = icmp sgt i32 %5, %1
  %8 = or i1 %6, %7
  %9 = add nsw i32 %5, -1
  %10 = select i1 %8, i32 %1, i32 %9
  %11 = cmpxchg i32 addrspace(3)* %0, i32 %5, i32 %10 seq_cst seq_cst, !mem.scope !12
  %12 = extractvalue { i32, i1 } %11, 0
  %13 = icmp eq i32 %5, %12
  br i1 %13, label %14, label %4

; <label>:14:                                     ; preds = %4
  ret i32 %5
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Mathematical Functions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

define i32 @nvvm.min.i(i32, i32) #3 {
  %3 = icmp sgt i32 %0, %1
  %4 = select i1 %3, i32 %1, i32 %0
  ret i32 %4
}

define i32 @nvvm.min.ui(i32, i32) #3 {
  %3 = icmp ugt i32 %0, %1
  %4 = select i1 %3, i32 %1, i32 %0
  ret i32 %4
}

define i64 @nvvm.min.ll(i64, i64) #3 {
  %3 = icmp sgt i64 %0, %1
  %4 = select i1 %3, i64 %1, i64 %0
  ret i64 %4
}

define i64 @nvvm.min.ull(i64, i64) #3 {
  %3 = icmp ugt i64 %0, %1
  %4 = select i1 %3, i64 %1, i64 %0
  ret i64 %4
}

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Shuffle Instructions

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Function Attrs: nounwind readnone
declare i32 @llvm.amdgcn.mbcnt.lo(i32, i32) #0

; Function Attrs: nounwind readnone
declare i32 @llvm.amdgcn.mbcnt.hi(i32, i32) #0

; Function Attrs: alwaysinline convergent nounwind readnone
declare i32 @llvm.amdgcn.ds.bpermute(i32, i32) #5

; Function Attrs: alwaysinline convergent nounwind readnone
define i32 @nvvm.shfl.idx.i32(i32, i32, i32) local_unnamed_addr #5 {
  %4 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #3
  %5 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %4) #3
  %6 = srem i32 %5, 64
  %7 = sub i32 0, %2
  %8 = and i32 %6, %7
  %9 = add nsw i32 %8, %1
  %10 = shl i32 %9, 2
  %11 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %10, i32 %0) #5
  ret i32 %11
}

; Function Attrs: alwaysinline convergent nounwind readnone
define i32 @nvvm.shfl.up.i32(i32, i32, i32) local_unnamed_addr #5 {
  %4 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #0
  %5 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %4) #0
  %6 = srem i32 %5, 64
  %7 = sub i32 %6, %1
  %8 = sub i32 0, %2
  %9 = and i32 %6, %8
  %10 = icmp slt i32 %7, %9
  %11 = select i1 %10, i32 %6, i32 %7
  %12 = shl i32 %11, 2
  %13 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %12, i32 %0) #5
  ret i32 %13
}

; Function Attrs: alwaysinline convergent nounwind readnone
define float @nvvm.shfl.up.f32(float, i32, i32) local_unnamed_addr #5 {
  %4 = bitcast float %0 to i32
  %5 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #0
  %6 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %5) #0
  %7 = srem i32 %6, 64
  %8 = sub i32 %7, %1
  %9 = sub i32 0, %2
  %10 = and i32 %7, %9
  %11 = icmp slt i32 %8, %10
  %12 = select i1 %11, i32 %7, i32 %8
  %13 = shl i32 %12, 2
  %14 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %13, i32 %4) #5
  %15 = bitcast i32 %14 to float
  ret float %15
}

; Function Attrs: alwaysinline convergent nounwind readnone
define i32 @nvvm.shfl.down.i32(i32, i32, i32) local_unnamed_addr #5 {
  %4 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #0
  %5 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %4) #0
  %6 = srem i32 %5, 64
  %7 = add nsw i32 %2, -1
  %8 = and i32 %6, %7
  %9 = add i32 %8, %1
  %10 = icmp uge i32 %9, %2
  %11 = select i1 %10, i32 0, i32 %1
  %12 = add i32 %11, %6
  %13 = shl i32 %12, 2
  %14 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %13, i32 %0) #5
  ret i32 %14
}

; Function Attrs: alwaysinline convergent nounwind readnone
define i32 @nvvm_shfl_down_i32(i32, i32, i32) local_unnamed_addr #5 {
  %retvalue = call i32 @nvvm.shfl.down.i32(i32 %0, i32 %1, i32 %2)
  ret i32 %retvalue;
}

; Function Attrs: alwaysinline convergent nounwind readnone
define float @nvvm.shfl.down.f32(float, i32, i32) local_unnamed_addr #5 {
  %4 = bitcast float %0 to i32
  %5 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #0
  %6 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %5) #0
  %7 = srem i32 %6, 64
  %8 = add nsw i32 %2, -1
  %9 = and i32 %7, %8
  %10 = add i32 %9, %1
  %11 = icmp uge i32 %10, %2
  %12 = select i1 %11, i32 0, i32 %1
  %13 = add i32 %12, %7
  %14 = shl i32 %13, 2
  %15 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %14, i32 %4) #5
  %16 = bitcast i32 %15 to float
  ret float %16
}

; Function Attrs: alwaysinline convergent nounwind readnone
define i32 @nvvm.shfl.bfly.i32(i32, i32, i32) local_unnamed_addr #5 {
  %4 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #0
  %5 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %4) #0
  %6 = srem i32 %5, 64
  %7 = xor i32 %6, %1
  %8 = add nsw i32 %6, %2
  %9 = sub i32 0, %2
  %10 = and i32 %8, %9
  %11 = icmp sge i32 %7, %10
  %12 = select i1 %11, i32 %6, i32 %7
  %13 = shl i32 %12, 2
  %14 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %13, i32 %0)
  ret i32 %14
}

; Function Attrs: alwaysinline convergent nounwind readnone
define float @nvvm.shfl.bfly.f32(float, i32, i32) local_unnamed_addr #5 {
  %4 = bitcast float %0 to i32
  %5 = tail call i32 @llvm.amdgcn.mbcnt.lo(i32 -1, i32 0) #0
  %6 = tail call i32 @llvm.amdgcn.mbcnt.hi(i32 -1, i32 %5) #0
  %7 = srem i32 %6, 64
  %8 = xor i32 %7, %1
  %9 = add nsw i32 %7, %2
  %10 = sub i32 0, %2
  %11 = and i32 %9, %10
  %12 = icmp sge i32 %8, %11
  %13 = select i1 %12, i32 %7, i32 %8
  %14 = shl i32 %13, 2
  %15 = tail call i32 @llvm.amdgcn.ds.bpermute(i32 %14, i32 %4) #5
  %16 = bitcast i32 %15 to float
  ret float %16
}

attributes #0 = { nounwind readnone }
attributes #1 = { convergent nounwind }
attributes #2 = { alwaysinline }
attributes #3 = { alwaysinline nounwind }
attributes #4 = { alwaysinline norecurse nounwind readnone }
attributes #5 = { alwaysinline convergent nounwind readnone }
attributes #6 = { alwaysinline nounwind readnone }

!0 = !{}
!1 = !{!2, !6, i64 12}
!2 = !{!"hsa_kernel_dispatch_packet_s", !3, i64 0, !3, i64 2, !3, i64 4, !3, i64 6, !3, i64 8, !3, i64 10, !6, i64 12, !6, i64 16, !6, i64 20, !6, i64 24, !6, i64 28, !7, i64 32, !8, i64 40, !6, i64 48, !7, i64 56, !9, i64 64}
!3 = !{!"short", !4, i64 0}
!4 = !{!"omnipotent char", !5, i64 0}
!5 = !{!"Simple C/C++ TBAA"}
!6 = !{!"int", !4, i64 0}
!7 = !{!"long", !4, i64 0}
!8 = !{!"any pointer", !4, i64 0}
!9 = !{!"hsa_signal_s", !7, i64 0}
!10 = !{!2, !3, i64 4}
!11 = !{ i32 0, i32 4096 }
!12 = !{i32 5}
