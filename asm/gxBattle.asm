
gxBattle:
    push    {lr}
    ldr     r0, gBattleTypeFlags
    ldr     r1, [r0]
    cmp     r1, #0 @ Check if the current battle is wild
    bne     skipBattle
    
    @ Skip entirely if the battle has rolled this call

    ldr     r0, gxData
    ldrb    r1, [r0]
    cmp     r1, #1
    beq     skipBattle

    ldr     r0, gxData
    mov     r1, #1
    strb    r1, [r0]

gxCanMonSpawn:
    @ Check to see if mon can even spawn in this map
    ldr     r6, GetCurrentMapWildMonHeader
    bl      branch

    mov     r1, #20
    mul     r0, r1
    ldr     r1, gWildMonHeaders
    add     r0, r1
    mov     r7, r0
    ldr     r0, VarUnusedMon
    ldr     r6, VarGet
    bl      branch
    
    mov     r1, r0
    mov     r0, r7
    ldr     r6, MapHasMon
    bl      branch
    
    cmp     r0, #1 @ TRUE
    bne     skipBattle
    
gxFlipCoinStart:
    @ Roll to see if mon should appear
    bl      gxFlipCoin

gxFlipCoinEnd:
    @ 50% chance to roll for mon
    cmp     r0, #1
    bne     skipBattle

loadOT:
    @ Load wild mon's OT (Why not just read from save?)
    ldr     r0, gEnemyParty
    mov     r1, #1 @ MON_DATA_OT_ID
    mov     r2, #0
    ldr     r6, GetMonData
    bl      branch
    mov     r5, r0 @ Move OT into r5

rollShiny:
    bl      gxRollShiny

skipBattle:
    pop     {pc}

branch:
    bx      r6

gxFlipCoin:
    ldr     r6, Random
    bl      branch
    @ 0x0201A2A3
    mov     r1, #2
    ldr     r6, __umodsi3
    bl      branch
    @ 0x0201A2AC
    bl      gxFlipCoinEnd

gxRollShiny:
    mov     r7, #0 @ Loop counter

    @ Check if Pokémon is Shiny
rollLoop: 
    @ Roll personality
    ldr     r6, Random @ Return 16-bit random value
    bl      branch
    
    mov     r4, r0 @ Move result into r4
    ldr     r6, Random @ Return 16-bit random value
    bl      branch
    lsl     r0, #16
    orr     r4, r0
    
    mov     r0, r5
    mov     r1, r4
    ldr     r6, IsShinyOtIdPersonality
    bl      branch
    
    cmp     r0, #1
    beq     loopEnd @ Pokémon is shiny, proceed with VBlankIntr

    add     r7, #1 @ Increment loop counter
    ldr     r6, RollCount
    ldrh    r1, [r6]
    cmp     r7, r6
    ble     rollLoop
    
loopEnd:
    @ Pull the species from the rolled variable
    ldr     r0, VarUnusedMon
    ldr     r6, VarGet
    bl      branch
    
    mov     r7, r0 @ Species

    @ Get the wild Pokémon's level (this is left untouched)
    ldr     r0, gEnemyParty
    mov     r1, #56
    ldr     r6, GetMonData
    bl      branch
    
    mov     r6, r0 @ Level

    @ Recreate mon using existing variables
    add     sp, sp, #-16

    ldr     r0, gEnemyParty
    mov     r1, #1 @ hasFixedPersonality
    str     r1, [sp]
    mov     r1, r4
    str     r1, [sp, #4]
    mov     r1, #3 @ otIdType
    str     r1, [sp, #8]
    str     r5, [sp, #12] @ Player OT
    mov     r1, r7 @ Species
    mov     r2, r6 @ Level
    mov     r3, #32 @ Fixed IVs
    ldr     r6, CreateMon
    bl      branch

    add     sp, sp, #16

    @ Get the TM Move
    ldr     r0, VarUnusedMon
    add     r0, #1 @ VarUnusedTM
    ldr     r6, VarGet
    bl      branch
    
    mov     r5, r0

    ldr     r0, gEnemyParty
    ldr     r6, pokemon_has_move
    bl      branch
    
    cmp     r0, #1
    beq     end @ Mon already knows TM (Splash, Dragon Claw, etc.)

    ldr     r0, gEnemyParty
    mov     r1, r5
    mov     r2, #0
    ldr     r6, SetMonMoveSlot
    bl      branch
    
    bl      skipBattle


.align
@ gxRollShiny
IsShinyOtIdPersonality:
.ifdef BASE
    .long   0x08040ce1
.endif
.ifdef REV1
    .long   0x08040d01
.endif
.ifdef REV2
    .long   0x08040d01
.endif
RollCount:
    .word   0x0400
VarUnusedMon:
    .word   0x40C8
VarGet:
.ifdef BASE
    .long   0x08069255
.endif
.ifdef REV1
    .long   0x08069275
.endif
.ifdef REV2
    .long   0x08069275
.endif
gEnemyParty:
    .long   0x030045c0
GetMonData:
    .long   0x0803cb61
CreateMon:
    .long   0x0803a799
pokemon_has_move:
.ifdef BASE
    .long   0x0806f03d
.endif
.ifdef REV1
    .long   0x0806f05d
.endif
.ifdef REV2
    .long   0x0806f05d
.endif
SetMonMoveSlot:
    .long   0x0803b6a5

@ gxFlipCoin
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

@ gxCanMonSpawn
GetCurrentMapWildMonHeader:
.ifdef BASE
    .long   0x08084d6d
.endif
.ifdef REV1
    .long   0x08084d8d
.endif
.ifdef REV2
    .long   0x08084d8d
.endif

gWildMonHeaders:
.ifdef BASE
    .long   0x0839d454
.endif
.ifdef REV1
    .long   0x0839d46c
.endif
.ifdef REV2
    .long   0x0839d46c
.endif

MapHasMon:
.ifdef BASE
    .long   0x08110ba5
.endif
.ifdef REV1
    .long   0x08110bc5
.endif
.ifdef REV2
    .long   0x08110bc5
.endif

@ gxBattle
gBattleTypeFlags:
    .long   0x020239f8
gxData:
    .long   0x0201A4A1
