ldr r0, gSaveBlock1Ptr
ldr r0, [r0] @ Get gSaveblock1 address
ldr r1, ScriptOffset
add r0, r1 @ Add script offset to gSaveblock1 address to reach randomgiveitem address
bx r0

.align
gSaveBlock1Ptr:
    .long 0x03005d8c
ScriptOffset:
    .long 0x0000373B
