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
    
    ldr     r0, iforgot
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
.ifdef RUBY
    .ifdef BASE
        .long   0x08081961
    .endif
    .ifdef REV1
        .long   0x08081981
    .endif
    .ifdef REV2
        .long   0x08081981
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x08081961
    .endif
    .ifdef REV1
        .long   0x08081981
    .endif
    .ifdef REV2
        .long   0x08081981
    .endif
.endif

Task_StartMenu:
.ifdef RUBY
    .ifdef BASE
        .long   0x08071255
    .endif
    .ifdef REV1
        .long   0x08071275
    .endif
    .ifdef REV2
        .long   0x08071275
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x08071259
    .endif
    .ifdef REV1
        .long   0x08071279
    .endif
    .ifdef REV2
        .long   0x08071279
    .endif
.endif

FindTaskIdByFunc:
.ifdef RUBY
    .ifdef BASE
        .long   0x0807acf5
    .endif
    .ifdef REV1
        .long   0x0807ad15
    .endif
    .ifdef REV2
        .long   0x0807ad15
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x0807acf9
    .endif
    .ifdef REV1
        .long   0x0807ad19
    .endif
    .ifdef REV2
        .long   0x0807ad19
    .endif
.endif

gLocalTime:
    .long   0x03004038
CalcTimeDifference:
.ifdef RUBY
    .long   0x08009625
.endif
.ifdef SAPP
    .long   0x08009535
.endif
gxTimeDifference:
    .long   0x0201A490
gxTimeStart:
    .long   0x0201A498
gxOutbreakText:
    .long   0x02028DF8
gStringVar1:
    .long   0x020231cc
AlignInt2InMenuWindow:
.ifdef RUBY
    .ifdef BASE
        .long   0x08072c45
    .endif
    .ifdef REV1
        .long   0x08072c65
    .endif
    .ifdef REV2
        .long   0x08072c65
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x08072c49
    .endif
    .ifdef REV1
        .long   0x08072c69
    .endif
    .ifdef REV2
        .long   0x08072c69
    .endif
.endif

Menu_DrawStdWindowFrame:
.ifdef RUBY
    .ifdef BASE
        .long   0x08071f09
    .endif
    .ifdef REV1
        .long   0x08071f29
    .endif
    .ifdef REV2
        .long   0x08071f29
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x08071f0d
    .endif
    .ifdef REV1
        .long   0x08071f2d
    .endif
    .ifdef REV2
        .long   0x08071f2d
    .endif
.endif

Menu_PrintText:
.ifdef RUBY
    .ifdef BASE
        .long   0x08071e51
    .endif
    .ifdef REV1
        .long   0x08071e71
    .endif
    .ifdef REV2
        .long   0x08071e71
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x08071e55
    .endif
    .ifdef REV1
        .long   0x08071e75
    .endif
    .ifdef REV2
        .long   0x08071e75
    .endif
.endif

gxDataTime:
    .long   0x0201A4A0
varTimer:
    .long   0x02026C08
iforgot:
    .long   0x0201A181
filler0:
    .long   0x00000000

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

gxBattleStart:
    push    {lr}
    ldr     r0, gBattleTypeFlags
    ldr     r1, [r0]
    cmp     r1, #0 @ Check if the current battle is wild
    bne     skipBattle
    
    @ Skip entirely if the battle has rolled this call

    ldr     r0, gxData1
    ldrb    r1, [r0]
    cmp     r1, #1
    beq     skipBattle

    ldr     r0, gxData1
    mov     r1, #1
    strb    r1, [r0]

gxCanMonSpawn:
    @ Check to see if mon can even spawn in this map
    ldr     r6, GetCurrentMapWildMonHeader
    bl      branch1

    mov     r1, #20
    mul     r0, r1
    ldr     r1, gWildMonHeaders
    add     r0, r1
    mov     r7, r0
    ldr     r0, VarUnusedMon
    ldr     r6, VarGet
    bl      branch1
    
    mov     r1, r0
    mov     r0, r7
    ldr     r6, MapHasMon
    bl      branch1
    
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
    bl      branch1
    mov     r5, r0 @ Move OT into r5

rollShiny:
    bl      gxRollShiny

skipBattle:
    pop     {pc}

branch1:
    bx      r6

gxFlipCoin:
    ldr     r6, Random
    bl      branch1
    @ 0x0201A2A3
    mov     r1, #2
    ldr     r6, __umodsi3
    bl      branch1
    @ 0x0201A2AC
    bl      gxFlipCoinEnd

gxRollShiny:
    mov     r7, #0 @ Loop counter

    @ Check if Pokémon is Shiny
rollLoop: 
    @ Roll personality
    ldr     r6, Random @ Return 16-bit random value
    bl      branch1
    
    mov     r4, r0 @ Move result into r4
    ldr     r6, Random @ Return 16-bit random value
    bl      branch1
    lsl     r0, #16
    orr     r4, r0
    
    mov     r0, r5
    mov     r1, r4
    ldr     r6, IsShinyOtIdPersonality
    bl      branch1
    
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
.ifdef RUBY
    .ifdef BASE
        .long   0x08040ce1
    .endif
    .ifdef REV1
        .long   0x08040d01
    .endif
    .ifdef REV2
        .long   0x08040d01
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x08040ce1
    .endif
    .ifdef REV1
        .long   0x08040d01
    .endif
    .ifdef REV2
        .long   0x08040d01
    .endif
.endif

RollCount:
    .word   0x0400
VarUnusedMon:
    .word   0x40C8
VarGet:
.ifdef RUBY
    .ifdef BASE
        .long   0x08069255
    .endif
    .ifdef REV1
        .long   0x08069275
    .endif
    .ifdef REV2
        .long   0x08069275
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x08069259
    .endif
    .ifdef REV1
        .long   0x08069279
    .endif
    .ifdef REV2
        .long   0x08069279
    .endif
.endif

gEnemyParty:
    .long   0x030045c0
GetMonData:
    .long   0x0803cb61
CreateMon:
    .long   0x0803a799
pokemon_has_move:
.ifdef RUBY
    .ifdef BASE
        .long   0x08040ce1
    .endif
    .ifdef REV1
        .long   0x08040d01
    .endif
    .ifdef REV2
        .long   0x08040d01
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x0806f041
    .endif
    .ifdef REV1
        .long   0x0806f061
    .endif
    .ifdef REV2
        .long   0x0806f061
    .endif
.endif

SetMonMoveSlot:
    .long   0x0803b6a5

@ gxFlipCoin
__umodsi3:
.ifdef RUBY
    .ifdef BASE
        .long   0x081e0f09
    .endif
    .ifdef REV1
        .long   0x081e0f21
    .endif
    .ifdef REV2
        .long   0x081e0f21
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x081e0e99
    .endif
    .ifdef REV1
        .long   0x081e0eb1
    .endif
    .ifdef REV2
        .long   0x081e0eb1
    .endif
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
@ Same in both games
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
.ifdef RUBY
    .ifdef BASE
        .long   0x0839d454
    .endif
    .ifdef REV1
        .long   0x0839d46c
    .endif
    .ifdef REV2
        .long   0x0839d46c
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x0839d29c
    .endif
    .ifdef REV1
        .long   0x0839d2b4
    .endif
    .ifdef REV2
        .long   0x0839d2b4
    .endif
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
gxData1:
    .long   0x0201A4A1
filler1:
    .long   0x00000000
    .long   0x00000000

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

gxSelectMonStart:
    push    {lr}
    @ Random to roll 16-bit word, result in r0
    ldr     r6, Random1
    bl      branch2

    @ Modulo 84 (Pokémon count in list), result in r0
    mov     r1, #84
    ldr     r6, __umodsi31
    bl      branch2

    @ Set variables accordingly
    ldr     r2, MonAddress
    add     r0, r0 @ x2 since mons are words
    mov     r5, r0 @ Temp store to offset to Moves later
    add     r2, r0
    ldrh    r1, [r2]
    ldr     r0, VarUnusedMon1

    ldr     r6, VarSet
    bl      branch2

    ldr     r0, VarUnusedMon1
    add     r0, #1

    ldr     r2, MonAddress
    ldr     r1, MonLength
    add     r2, r1
    add     r2, r5
    ldrh    r1, [r2]
    
    ldr     r6, VarSet
    bl      branch2

    pop     {pc}

branch2:
    bx      r6

.align
Random1:
.ifdef BASE
    .long   0x08040e85
.endif
.ifdef REV1
    .long   0x08040ea5
.endif
.ifdef REV2
    .long   0x08040ea5
.endif

__umodsi31:
.ifdef RUBY
    .ifdef BASE
        .long   0x081e0f09
    .endif
    .ifdef REV1
        .long   0x081e0f21
    .endif
    .ifdef REV2
        .long   0x081e0f21
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x081e0e99
    .endif
    .ifdef REV1
        .long   0x081e0eb1
    .endif
    .ifdef REV2
        .long   0x081e0eb1
    .endif
.endif

MonAddress:
    .long   0x0201a020
VarUnusedMon1:
    .word   0x40C8
MonLength:
    .word   0xA8
VarSet:
.ifdef RUBY
    .ifdef BASE
        .long   0x08069271
    .endif
    .ifdef REV1
        .long   0x08069291
    .endif
    .ifdef REV2
        .long   0x08069291
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x08069275
    .endif
    .ifdef REV1
        .long   0x08069295
    .endif
    .ifdef REV2
        .long   0x08069295
    .endif
.endif

filler2:
    .long   0x00000000
    .long   0x00000000
    .long   0x00000000

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

gxInitStart:
    push    {r0-r7, lr}

    mov     r7, #0
    ldr     r0, gxTimeStart1
    ldr     r1, gLocalTime1
copy:
    ldr     r2, [r1]
    str     r2, [r0]
    add     r0, #4
    add     r1, #4
    add     r7, #1
    cmp     r7, #2
    bne     copy
    ldr     r0, gxDataTime2
    mov     r1, #0
    strb    r1, [r0]

copyTM:
    mov     r7, #0
    ldr     r0, TMHMMoves
    ldr     r1, VarMove
    ldrh    r3, [r1]
loopTM:
    ldrh    r2, [r0]
    cmp     r2, r3
    beq     matchFound
    add     r0, #2
    add     r7, #1
    cmp     r7, #58
    bge     exit
    bl      loopTM

matchFound:
    ldr     r0, TM_FocusPunch
    add     r0, r7
    ldr     r1, VarGift
    strh    r0, [r1]

exit:
    pop     {r0-r7, pc}

.align
gxTimeStart1:
    .long   0x0201A498
gLocalTime1:
    .long   0x03004038
gxDataTime2:
    .long   0x0201A4A0

VarMove:
    .long   0x02026C06
VarGift:
    .long   0x02026C0A
TMHMMoves:
.ifdef RUBY
    .ifdef BASE
        .long   0x08376504
    .endif
    .ifdef REV1
        .long   0x0837651c
    .endif
    .ifdef REV2
        .long   0x0837651c
    .endif
.endif
.ifdef SAPP
    .ifdef BASE
        .long   0x08376494
    .endif
    .ifdef REV1
        .long   0x083764ac
    .endif
    .ifdef REV2
        .long   0x083764ac
    .endif
.endif

TM_FocusPunch:
    .word   0x0121

filler3:
    .long   0x00000000
    .long   0x00000000
    .long   0x00000000
    .long   0x00000000
    .long   0x00000000
.align
    .word   0x0000
