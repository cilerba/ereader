    push    {lr}
    @ Random to roll 16-bit word, result in r0
    ldr     r6, Random
    bl      branch

    @ Modulo 84 (Pokémon count in list), result in r0
    mov     r1, #84
    ldr     r6, __umodsi3
    bl      branch

    @ Set variables accordingly
    ldr     r2, MonAddress
    add     r0, r0 @ x2 since mons are words
    mov     r5, r0 @ Temp store to offset to Moves later
    add     r2, r0
    ldrh    r1, [r2]
    ldr     r0, VarUnusedMon

    ldr     r6, VarSet
    bl      branch

    ldr     r0, VarUnusedMon
    add     r0, #1

    ldr     r2, MonAddress
    ldr     r1, MonLength
    add     r2, r1
    add     r2, r5
    ldrh    r1, [r2]
    
    ldr     r6, VarSet
    bl      branch

    pop     {pc}

branch:
    bx      r6

.align
Random:
.ifdef BASE
    .long   0x08040e85
.endif
.ifdef REV1
    .long   0x08040ea5
.endif
.ifdef REV2
    .long   0x08040ea5
.endif
__umodsi3:
.ifdef BASE
    .long   0x081e0f09
.endif
.ifdef REV1
    .long   0x081e0f21
.endif
.ifdef REV2
    .long   0x081e0f21
.endif
MonAddress:
    .long   0x0201a020
VarUnusedMon:
    .word   0x40C8
MonLength:
    .word   0xA8
VarSet:
.ifdef BASE
    .long   0x08069271
.endif
.ifdef REV1
    .long   0x08069291
.endif
.ifdef REV2
    .long   0x08069291
.endif
