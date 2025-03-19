    ldr     r0, =0x02028506
    ldrh    r0, [r0]
    ldr     r1, =0x02026C0C
    strh    r0, [r1]
    bx      lr
