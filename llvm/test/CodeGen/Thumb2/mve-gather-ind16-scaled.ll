; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc -mtriple=thumbv8.1m.main-none-none-eabi -mattr=+mve.fp -enable-arm-maskedgatscat %s -o - | FileCheck %s

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_i16(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8i16_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1, uxtw #1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> undef)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x half> @scaled_v8f16_i16(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8f16_i16:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1, uxtw #1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %i16_ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %ptrs = bitcast <8 x i16*> %i16_ptrs to <8 x half*>
  %gather = call <8 x half> @llvm.masked.gather.v8f16.v8p0f16(<8 x half*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x half> undef)
  ret <8 x half> %gather
}

define arm_aapcs_vfpcc <8 x half> @scaled_v8f16_half(half* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8f16_half:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1, uxtw #1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds half, half* %base, <8 x i32> %offs.zext
  %gather = call <8 x half> @llvm.masked.gather.v8f16.v8p0f16(<8 x half*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x half> undef)
  ret <8 x half> %gather
}

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_sext(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8i16_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    .save {r4, r5, r7, lr}
; CHECK-NEXT:    push {r4, r5, r7, lr}
; CHECK-NEXT:    vldrh.s32 q0, [r1]
; CHECK-NEXT:    vldrh.s32 q1, [r1, #8]
; CHECK-NEXT:    vshl.i32 q0, q0, #1
; CHECK-NEXT:    vshl.i32 q1, q1, #1
; CHECK-NEXT:    vadd.i32 q0, q0, r0
; CHECK-NEXT:    vadd.i32 q1, q1, r0
; CHECK-NEXT:    vmov r2, s2
; CHECK-NEXT:    vmov r3, s3
; CHECK-NEXT:    vmov r5, s1
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov r1, s5
; CHECK-NEXT:    vmov r4, s7
; CHECK-NEXT:    ldrh.w r12, [r2]
; CHECK-NEXT:    vmov r2, s0
; CHECK-NEXT:    ldrh.w lr, [r3]
; CHECK-NEXT:    vmov r3, s6
; CHECK-NEXT:    ldrh r5, [r5]
; CHECK-NEXT:    ldrh r0, [r0]
; CHECK-NEXT:    ldrh r1, [r1]
; CHECK-NEXT:    ldrh r4, [r4]
; CHECK-NEXT:    ldrh r2, [r2]
; CHECK-NEXT:    ldrh r3, [r3]
; CHECK-NEXT:    vmov.16 q0[0], r2
; CHECK-NEXT:    vmov.16 q0[1], r5
; CHECK-NEXT:    vmov.16 q0[2], r12
; CHECK-NEXT:    vmov.16 q0[3], lr
; CHECK-NEXT:    vmov.16 q0[4], r0
; CHECK-NEXT:    vmov.16 q0[5], r1
; CHECK-NEXT:    vmov.16 q0[6], r3
; CHECK-NEXT:    vmov.16 q0[7], r4
; CHECK-NEXT:    pop {r4, r5, r7, pc}
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.sext = sext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.sext
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> undef)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x half> @scaled_v8f16_sext(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8f16_sext:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.s32 q0, [r1]
; CHECK-NEXT:    vshl.i32 q0, q0, #1
; CHECK-NEXT:    vadd.i32 q1, q0, r0
; CHECK-NEXT:    vmov r2, s5
; CHECK-NEXT:    vldr.16 s0, [r2]
; CHECK-NEXT:    vmov r3, s4
; CHECK-NEXT:    vmov r2, s0
; CHECK-NEXT:    vldr.16 s0, [r3]
; CHECK-NEXT:    vmov r3, s0
; CHECK-NEXT:    vmov.16 q0[0], r3
; CHECK-NEXT:    vmov.16 q0[1], r2
; CHECK-NEXT:    vmov r2, s6
; CHECK-NEXT:    vldr.16 s8, [r2]
; CHECK-NEXT:    vmov r2, s8
; CHECK-NEXT:    vmov.16 q0[2], r2
; CHECK-NEXT:    vmov r2, s7
; CHECK-NEXT:    vldr.16 s4, [r2]
; CHECK-NEXT:    vmov r2, s4
; CHECK-NEXT:    vldrh.s32 q1, [r1, #8]
; CHECK-NEXT:    vmov.16 q0[3], r2
; CHECK-NEXT:    vshl.i32 q1, q1, #1
; CHECK-NEXT:    vadd.i32 q1, q1, r0
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vldr.16 s8, [r0]
; CHECK-NEXT:    vmov r0, s8
; CHECK-NEXT:    vmov.16 q0[4], r0
; CHECK-NEXT:    vmov r0, s5
; CHECK-NEXT:    vldr.16 s8, [r0]
; CHECK-NEXT:    vmov r0, s8
; CHECK-NEXT:    vmov.16 q0[5], r0
; CHECK-NEXT:    vmov r0, s6
; CHECK-NEXT:    vldr.16 s8, [r0]
; CHECK-NEXT:    vmov r0, s8
; CHECK-NEXT:    vmov.16 q0[6], r0
; CHECK-NEXT:    vmov r0, s7
; CHECK-NEXT:    vldr.16 s4, [r0]
; CHECK-NEXT:    vmov r0, s4
; CHECK-NEXT:    vmov.16 q0[7], r0
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.sext = sext <8 x i16> %offs to <8 x i32>
  %i16_ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.sext
  %ptrs = bitcast <8 x i16*> %i16_ptrs to <8 x half*>
  %gather = call <8 x half> @llvm.masked.gather.v8f16.v8p0f16(<8 x half*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x half> undef)
  ret <8 x half> %gather
}

define arm_aapcs_vfpcc <8 x i16> @unsigned_scaled_v8i16_i8(i16* %base, <8 x i8>* %offptr) {
; CHECK-LABEL: unsigned_scaled_v8i16_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1, uxtw #1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i8>, <8 x i8>* %offptr, align 1
  %offs.zext = zext <8 x i8> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> undef)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x half> @unsigned_scaled_v8f16_i8(i16* %base, <8 x i8>* %offptr) {
; CHECK-LABEL: unsigned_scaled_v8f16_i8:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrb.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1, uxtw #1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i8>, <8 x i8>* %offptr, align 1
  %offs.zext = zext <8 x i8> %offs to <8 x i32>
  %i16_ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %ptrs = bitcast <8 x i16*> %i16_ptrs to <8 x half*>
  %gather = call <8 x half> @llvm.masked.gather.v8f16.v8p0f16(<8 x half*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x half> undef)
  ret <8 x half> %gather
}

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_i16_passthru0t(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8i16_i16_passthru0t:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1, uxtw #1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> zeroinitializer)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_i16_passthru1t(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8i16_i16_passthru1t:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vldrh.u16 q0, [r0, q1, uxtw #1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_i16_passthru1f(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8i16_i16_passthru1f:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    movw r2, #65487
; CHECK-NEXT:    vmov.i16 q0, #0x1
; CHECK-NEXT:    vmsr p0, r2
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vldrht.u16 q2, [r0, q1, uxtw #1]
; CHECK-NEXT:    vpsel q0, q2, q0
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*> %ptrs, i32 2, <8 x i1> <i1 true, i1 true, i1 false, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_i16_passthru0f(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8i16_i16_passthru0f:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    movw r2, #65523
; CHECK-NEXT:    vmsr p0, r2
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vpst
; CHECK-NEXT:    vldrht.u16 q0, [r0, q1, uxtw #1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*> %ptrs, i32 2, <8 x i1> <i1 true, i1 false, i1 true, i1 true, i1 true, i1 true, i1 true, i1 true>, <8 x i16> <i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0>)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_i16_passthru_icmp0(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8i16_i16_passthru_icmp0:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vpt.s16 gt, q1, zr
; CHECK-NEXT:    vldrht.u16 q0, [r0, q1, uxtw #1]
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %mask = icmp sgt <8 x i16> %offs, zeroinitializer
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*> %ptrs, i32 2, <8 x i1> %mask, <8 x i16> <i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0, i16 0>)
  ret <8 x i16> %gather
}

define arm_aapcs_vfpcc <8 x i16> @scaled_v8i16_i16_passthru_icmp1(i16* %base, <8 x i16>* %offptr) {
; CHECK-LABEL: scaled_v8i16_i16_passthru_icmp1:
; CHECK:       @ %bb.0: @ %entry
; CHECK-NEXT:    vmov.i16 q0, #0x1
; CHECK-NEXT:    vldrh.u16 q1, [r1]
; CHECK-NEXT:    vpt.s16 gt, q1, zr
; CHECK-NEXT:    vldrht.u16 q2, [r0, q1, uxtw #1]
; CHECK-NEXT:    vpsel q0, q2, q0
; CHECK-NEXT:    bx lr
entry:
  %offs = load <8 x i16>, <8 x i16>* %offptr, align 2
  %offs.zext = zext <8 x i16> %offs to <8 x i32>
  %ptrs = getelementptr inbounds i16, i16* %base, <8 x i32> %offs.zext
  %mask = icmp sgt <8 x i16> %offs, zeroinitializer
  %gather = call <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*> %ptrs, i32 2, <8 x i1> %mask, <8 x i16> <i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1, i16 1>)
  ret <8 x i16> %gather
}

declare <8 x i8> @llvm.masked.gather.v8i8.v8p0i8(<8 x i8*>, i32, <8 x i1>, <8 x i8>) #1
declare <8 x i16> @llvm.masked.gather.v8i16.v8p0i16(<8 x i16*>, i32, <8 x i1>, <8 x i16>) #1
declare <8 x half> @llvm.masked.gather.v8f16.v8p0f16(<8 x half*>, i32, <8 x i1>, <8 x half>) #1