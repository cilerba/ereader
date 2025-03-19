    push    {lr}
    push    {r4-r7}

    ldr     r0, gxTimeDifference
    ldr     r1, gxTimeStart
    ldr     r2, gLocalTime
    ldr     r6, CalcTimeDifference
    bl      branch

    mov     r0, #24
    mov     r1, #60
    mul     r0, r1
    ldr     r1, gxTimeDifference
    ldrh    r1, [r1]
    mul     r0, r1

    mov     r1, #60
    ldr     r2, gxTimeDifference
    add     r2, #2 @ Hours
    ldrb    r3, [r2]
    mul     r1, r3
    add     r2, #1 @ Minutes
    ldrb    r2, [r2]
    add     r1, r2
    add     r0, r1

    cmp     r0, #1
    blt     battleCheck
    
    ldr     r2, gxTimeStart
    ldr     r3, gLocalTime
    ldr     r4, [r3]
    str     r4, [r2]
    add     r2, #4
    add     r3, #4
    ldr     r4, [r3]
    str     r4, [r2]

    ldr     r2, gxDataTime
    ldrb    r1, [r2]
    add     r1, r0
    strb    r1, [r2]
    
    ldr     r2, varTimer
    strb    r1, [r2]

    cmp     r1, #60
    blt     battleCheck @ Event hasn't ended yet
    
restoreIntr:
    pop     {r4-r7}
    pop     {r0}
    mov     lr, r0
    
    ldr     r0, =0x0201A181
    mov     r1, #0
    strb    r1, [r0] 
    ldr     r0, varTimer
    mov     r1, #255
    strb    r1, [r0]
    ldr     r0, VBlankIntr
    ldr     r1, VBlankIntrPtr
    str     r0, [r1]
    bx      r0

battleCheck:
    @ Check to see if a battle is starting
    ldr     r0, Task_BattleStart
    ldr     r6, FindTaskIdByFunc
    bl      branch
    
    @ FindTaskIdByFunc returns 0xFF if false
    cmp     r0, #255
    beq     reset

    @ Run battle modifications
    ldr     r6, gxBattle
    bl      branch
    bl      intr

reset:  
    ldr     r0, gxData
    mov     r1, #0
    strb    r1, [r0]

startMenu:
    ldr     r0, Task_StartMenu
    ldr     r6, FindTaskIdByFunc
    bl      branch
    cmp     r0, #255
    beq     intr
    
    ldr     r0, gStringVar1
    ldr     r1, gxDataTime
    ldrb    r1, [r1]
    mov     r2, #60
    sub     r2, r1
    mov     r1, r2
    mov     r2, #12
    mov     r3, #1
    ldr     r6, AlignInt2InMenuWindow
    bl      branch

    mov     r0, #0
    mov     r1, #0
    mov     r2, #10
    mov     r3, #5
    ldr     r6, Menu_DrawStdWindowFrame
    bl      branch

    ldr     r0, gxOutbreakText
    mov     r1, #1
    mov     r2, #1
    ldr     r6, Menu_PrintText
    bl      branch

intr:
    pop     {r4-r7}
    pop     {r0}
    mov     lr, r0
    ldr     r0, VBlankIntr
    bx      r0


branch:
    bx      r6

.align
@ 0x0201A171
VBlankIntrPtr:
    .long   0x03001bcc
VBlankIntr:
    .long   0x08000571
gxBattle:
    .long   0x0201A291
gxData:
    .long   0x0201A4A1
Task_BattleStart:
.ifdef BASE
    .long   0x08081961
.endif
.ifdef REV1
    .long   0x08081981
.endif
.ifdef REV2
    .long   0x08081981
.endif
Task_StartMenu:
.ifdef BASE
    .long   0x08071255
.endif
.ifdef REV1
    .long   0x08071275
.endif
.ifdef REV2
    .long   0x08071275
.endif
FindTaskIdByFunc:
.ifdef BASE
    .long   0x0807acf5
.endif
.ifdef REV1
    .long   0x0807ad15
.endif
.ifdef REV2
    .long   0x0807ad15
.endif
gLocalTime:
    .long   0x03004038
CalcTimeDifference:
    .long   0x08009625
gxTimeDifference:
    .long   0x0201A490
gxTimeStart:
    .long   0x0201A498
gxOutbreakText:
    .long   0x02028DF8
gStringVar1:
    .long   0x020231cc
AlignInt2InMenuWindow:
.ifdef BASE
    .long   0x08072c45
.endif
.ifdef REV1
    .long   0x08072c65
.endif
.ifdef REV2
    .long   0x08072c65
.endif
Menu_DrawStdWindowFrame:
.ifdef BASE
    .long   0x08071f09
.endif
.ifdef REV1
    .long   0x08071f29
.endif
.ifdef REV2
    .long   0x08071f29
.endif
Menu_PrintText:
.ifdef BASE
    .long   0x08071e51
.endif
.ifdef REV1
    .long   0x08071e71
.endif
.ifdef REV2
    .long   0x08071e71
.endif
gxDataTime:
    .long   0x0201A4A0
varTimer:
    .long   0x02026C08
