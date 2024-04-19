ldr r1, gSaveBlock1Ptr
ldr r1, [r1] @ Load gSaveblock1 address into r1
ldr r0, UnusedOffset @ offset to gSaveBlock1->unused_3598
add r1, r0 @ Add offset to save address
ldr r0, EnemyRamPtr
mov r2, #0x2A @ Length of item printer table
swi 0xb @ CpuSet
bx lr

.align
gSaveBlock1Ptr:
    .long 0x03005d8c
UnusedOffset:
    .long 0x00003598
EnemyRamPtr:
    .long 0x02024744
