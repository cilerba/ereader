    ldr     r0, VBlankIntrPtr
    ldr     r1, VBlankHijack
    str     r1, [r0]
    bx      lr
    
.align
VBlankIntrPtr:
    .long   0x03001bcc
VBlankHijack:
    .long   0x0201A171
