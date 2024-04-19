start:
    push {r0-r7, lr}
    ldr r0, gSaveBlock1Ptr
    ldr r0, [r0] @ Load gSaveblock1 address
    ldr r1, GulpinOffset @ Load offset from gSaveBlock1 to unused_3598
    add r0, r1
    add r0, #0x2 @ Add two to skip the first two filler bytes
    movs r6, r0 @ Store address of first item in r6
    push {r6}
    ldr r1, VarGet
    movs r0, #0x80 @ Left shift 80 by 7 to get 4000 (Var value)
    lsl r0, r0, #7
    add r0, #1 @ Add 1 to get (VAR_TEMP_1 = 0x4001)
    mov r3, pc
    add r3, #5
    mov lr, r3
    bx r1 @ Call VarGet
    movs r5, #0
    cmp r0, #1 @ Common check
    bne uncommon
    mov r5, #6 @ Common item count
    mov r4, #0 @ Start point
    b randomStart
uncommon:
    cmp r0, #2
    bne rare
    mov r5, #16 @ Uncommon item count
    mov r4, #14 @ Start point offset
    b randomStart
rare:
    cmp r0, #3
    bne ultrarare
    mov r5, #8 @ Rare item count
    mov r4, #50 @ Start point offset
    b randomStart
ultrarare:
    cmp r0, #4
    bne randomStart
    mov r5, #4 @ Ultra rare item count
    mov r4, #70 @ Start point offset
    b randomStart
randomStart:
    pop {r6}
    add r6, r4
    push {r6}
    ldr r0, Random @ Places random result in r0
    mov r3, pc
    add r3, #5
    mov lr, r3
    bx r0
    mov r1, r5 @ Move item count register into r1 to act as parameter for modulo
    ldr r2, __umodsi3
    mov r3, pc
    add r3, #5
    mov lr, r3
    bx r2 @ Call modulo (Random() % itemCount)
    movs r5, #2
    mul r0, r0, r5
    pop {r4}
    add r4, r0
    ldr r6, VarSet
    movs r0, #0x80 @ VAR_TEMP_0 = 0x4000
    lsl r0, r0, #7
    ldrh r1, [r4]
    mov r5, pc
    add r5, #5
    mov lr, r5
    bx r6
    pop {r0-r7, pc}

.align
gSaveBlock1Ptr:
    .long 0x03005d8c
GulpinOffset:
    .long 0x00003598
VarSet:
    .long 0x0809D6B1
Random:
    .long 0x0806F5CD
__umodsi3:
    .long 0x082e7be1
VarGet:
    .long 0x0809d695
