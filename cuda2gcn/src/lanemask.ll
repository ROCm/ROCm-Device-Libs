target datalayout = "e-p:64:64-p1:64:64-p2:64:64-p3:32:32-p4:64:64-p5:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn--amdhsa"

; Function Attrs: alwaysinline nounwind
declare i32 @__ockl_activelane_u32() #0

; Function Attrs: alwaysinline nounwind
define i64 @__gcn_ballot64(i32 %a) #0 {
  %b = tail call i64 asm "v_cmp_ne_i32_e64 $0, 0, $1", "=s,v"(i32 %a) #1
  ret i64 %b
}

; Function Attrs: alwaysinline nounwind
define i64 @__gcn_lanemask_gt() local_unnamed_addr #0 {
entry:
  %call = tail call i32 @__ockl_activelane_u32() #0
  %call1 = tail call i64 @__gcn_ballot64(i32 1) #0
  %cmp = icmp eq i32 %call, 63
  br i1 %cmp, label %cond.end, label %cond.false

cond.false:                                       ; preds = %entry
  %add = add i32 %call, 1
  %sh_prom = zext i32 %add to i64
  %shl = shl i64 -1, %sh_prom
  %and = and i64 %shl, %call1
  br label %cond.end

cond.end:                                         ; preds = %entry, %cond.false
  %cond = phi i64 [ %and, %cond.false ], [ 0, %entry ]
  ret i64 %cond
}

; Function Attrs: alwaysinline nounwind
define i64 @__gcn_lanemask_lt() local_unnamed_addr #0 {
entry:
  %call = tail call i32 @__ockl_activelane_u32() #0
  %call1 = tail call i64 @__gcn_ballot64(i32 1) #0
  %cmp = icmp eq i32 %call, 0
  %.call1 = select i1 %cmp, i64 0, i64 %call1
  ret i64 %.call1
}

attributes #0 = { alwaysinline nounwind }
attributes #1 = { convergent nounwind readnone }

