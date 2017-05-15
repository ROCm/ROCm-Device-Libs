; ModuleID = 'bitsbytes.bc'

target datalayout = "e-p:64:64-p1:64:64-p2:64:64-p3:32:32-p4:64:64-p5:32:32-i64:64-v16:16-v24:32-v32:32-v48:64-v96:128-v192:256-v256:256-v512:512-v1024:1024-v2048:2048-n32:64"
target triple = "amdgcn--amdhsa"

;-------- T __nv_brev
;-------- T __nv_brevll

; Function Attrs: alwaysinline nounwind readnone
define i32 @__nv_brev(i32 %a) #3 {
  %b = tail call i32 @llvm.bitreverse.i32(i32 %a)
  ret i32 %b
}

; Function Attrs: alwaysinline nounwind readnone
define i64 @__nv_brevll(i64 %a) #3 {
  %b = tail call i64 @llvm.bitreverse.i64(i64 %a)
  ret i64 %b
}

;-------- T __nv_clz
;-------- T __nv_clzll

; Function Attrs: alwaysinline nounwind readnone
define i32 @__nv_clz(i32 %a) #3 {
  %b = tail call i32 @llvm.ctlz.i32(i32 %a, i1 false)
  ret i32 %b
}

; Function Attrs: alwaysinline nounwind readnone
define i32 @__nv_clzll(i64 %a) #3 {
  %b = tail call i64 @llvm.ctlz.i64(i64 %a, i1 false)
  %c = trunc i64 %b to i32
  ret i32 %c
}

;-------- T __nv_ffs
;-------- T __nv_ffsll

; Function Attrs: alwaysinline nounwind readnone
define i32 @__nv_ffsll(i64 %a) #3 {
  %1 = sub i64 0, %a
  %2 = and i64 %a, %1
  %3 = call i64 @llvm.ctlz.i64(i64 %2, i1 false)
  %4 = trunc i64 %3 to i32
  %5 = sub nsw i32 64, %4
  ret i32 %5
}

; Function Attrs: alwaysinline nounwind readnone
define i32 @__nv_ffs(i32 %a) #3 {
  %1 = sub i32 0, %a
  %2 = and i32 %a, %1
  %3 = call i32 @llvm.ctlz.i32(i32 %2, i1 false)
  %4 = sub nsw i32 32, %3
  ret i32 %4
}

;-------- T __nv_popc
;-------- T __nv_popcll

; Function Attrs: alwaysinline nounwind readnone
define i32 @__nv_popcll(i64) #3 {
   %2 = tail call i64 @llvm.ctpop.i64(i64 %0)
   %3 = trunc i64 %2 to i32
   ret i32 %3
}

; Function Attrs: alwaysinline nounwind readnone
define i32 @__nv_popc(i32) #3 {
  %2 = tail call i32 @llvm.ctpop.i32(i32 %0)
  ret i32 %2
}

; Function Attrs: alwaysinline nounwind readnone
declare i32 @llvm.bitreverse.i32(i32)

; Function Attrs: alwaysinline nounwind readnone
declare i64 @llvm.bitreverse.i64(i64)

; Function Attrs: alwaysinline nounwind readnone
declare i32 @llvm.ctlz.i32(i32, i1)

; Function Attrs: alwaysinline nounwind readnone
declare i64 @llvm.ctlz.i64(i64, i1)

; Function Attrs: alwaysinline nounwind readnone
declare i32 @llvm.ctpop.i32(i32)

; Function Attrs: alwaysinline nounwind readnone
declare i64 @llvm.ctpop.i64(i64)

attributes #0 = { readnone }
attributes #1 = { nounwind }
attributes #2 = { alwaysinline }
attributes #3 = { alwaysinline nounwind readnone }


