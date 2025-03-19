    push    {r0-r7, lr}

    mov     r7, #0
    ldr     r0, gxTimeStart
    ldr     r1, gLocalTime
copy:
    ldr     r2, [r1]
    str     r2, [r0]
    add     r0, #4
    add     r1, #4
    add     r7, #1
    cmp     r7, #2
    bne     copy
    ldr     r0, gxDataTime
    mov     r1, #0
    strb    r1, [r0]

copyTM:
    mov     r7, #0
    ldr     r0, TMHMMoves
    ldr     r1, VarMove
    ldrh    r3, [r1]
loopTM:
    ldrh    r2, [r0]
    cmp     r2, r3
    beq     matchFound
    add     r0, #2
    add     r7, #1
    cmp     r7, #58
    bge     exit
    bl      loopTM

matchFound:
    ldr     r0, TM_FocusPunch
    add     r0, r7
    ldr     r1, VarGift
    strh    r0, [r1]

exit:
    pop     {r0-r7, pc}

.align
gxTimeStart:
    .long   0x0201A498
gLocalTime:
    .long   0x03004038
gxDataTime:
    .long   0x0201A4A0

VarMove:
    .long   0x02026C06
VarGift:
    .long   0x02026C0A
TMHMMoves:
.ifdef BASE
    .long   0x08376504
.endif
.ifdef REV1
    .long   0x0837651c
.endif
.ifdef REV2
    .long   0x0837651c
.endif
TM_FocusPunch:
    .word   0x0121
