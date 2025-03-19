    ldr     r0, VBlankIntr
    ldr     r1, VBlankIntrPtr
    str     r1, [r0]
    bx      lr
.align
VBlankIntrPtr:
    .long   0x03001bcc
VBlankIntr:
    .long   0x08000571
