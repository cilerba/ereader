@ Credit to blisy
    mov     r0, #30
    ldr     r1, PreloadASMStart
    ldr     r2, TryWriteSector
    bx      r2

.align
PreloadASMStart:
    .long   0x02000064
TryWriteSector:
.ifdef BASE
    .long   0x08125441
.endif
.ifdef REV1
    .long   0x08125461
.endif
.ifdef REV2
    .long   0x08125461
.endif