VAR_TEMP_0 EQU $4000
VAR_TEMP_1 EQU $4001
VAR_TEMP_2 EQU $4002
VAR_TEMP_3 EQU $4003
VAR_TEMP_4 EQU $4004
VAR_TEMP_5 EQU $4005
VAR_TEMP_6 EQU $4006
VAR_TEMP_7 EQU $4007
VAR_TEMP_8 EQU $4008
VAR_TEMP_9 EQU $4009
VAR_TEMP_F EQU $400F

VAR_0x8000 EQU $8000
VAR_0x8001 EQU $8001
VAR_0x8004 EQU $8004
VAR_0x800A EQU $800A
VAR_0x800B EQU $800B
LASTRESULT EQU $800D

VAR_UNUSED_0x40C8 EQU $40C8 ; RS: GX Comm. [Pokémon]
VAR_UNUSED_0x40C9 EQU $40C9 ; RS: GX Comm. [Move]
VAR_UNUSED_0x40CA EQU $40CA ; RS: GX Comm. [Timer]
VAR_UNUSED_0x40CB EQU $40CB ; RS: GX Comm. [TM (Self)]
VAR_UNUSED_0x40CC EQU $40CC ; RS: GX Comm. [TM (Gift)]

VAR_GULPIN_0x40FF EQU $40FF ; E: Gulpin [Daily Shard]

VAR_ITEM_ID EQU $800E
FLAG_DAILY_GULPIN_0x920 EQU $920

FLAG_DAILY_UNKNOWN_8C3 EQU $8C9 ; RS: GX Comm. Daily Flag

LESS_THAN			EQU 0
EQUAL				EQU 1
GREATER_THAN		EQU 2
LESS_THAN_EQUAL		EQU 3
GREATER_THAN_EQUAL	EQU 4
NOT_EQUAL			EQU 5

STR_VAR_1 EQU $0
STR_VAR_2 EQU $1

FADE_FROM_BLACK  EQU 0
FADE_TO_BLACK    EQU 1
FADE_FROM_WHITE  EQU 2
FADE_TO_WHITE    EQU 3

TRUE EQU $1
FALSE EQU $0

SE_SUCCESS EQU 31
SE_FAILURE EQU 32
SE_SHOP EQU 95

MUS_RG_TEACHY_TV_MENU EQU $22e

STD_OBTAIN_ITEM EQU $00

; Gulpin Printer
COMMON		EQU $1
UNCOMMON 	EQU $2
RARE		EQU $3
ULTRARARE	EQU $4

end: MACRO
	db $02
	ENDM
return: MACRO
	db $03
	ENDM
callscr: MACRO
	db $04
	dd \1
	ENDM
goto: MACRO
	db $05
	dd \1
	ENDM
goto_if: MACRO
	db $06
	db \1
	dd \2
	ENDM
call_if: MACRO
	db $07
	db \1
	dd \2
	ENDM
gotostd: MACRO
	db $08
	db \1
	ENDM
callstd: MACRO
	db $09, \1
	ENDM
gotostd_if: MACRO
	db $0A
	db \1
	db \2
	ENDM
callstd_if: MACRO
	db $0B
	db \3
	db \2
	ENDM
returnram: MACRO
	db $0C
	ENDM
killscript: MACRO
	db $0D
	ENDM
setbyte: MACRO
	db $0E, \1
	ENDM
loadword: MACRO
	db $0F
	db \1
	dd \2
	ENDM
callc: MACRO
	db $4
	dd \1
	ENDM	
callnative: MACRO
	db $23
	dd \1
	ENDM
loadbyte: MACRO
	db $10
	db \1
	db \2
	ENDM
writebytetoaddr: MACRO
	db $11
	db \1
	dd \2
	ENDM
loadbytefromaddr: MACRO
	db $12
	db \1
	dd \2
	ENDM
setptrbyte: MACRO
	db $13
	db \1
	dd \2
	ENDM
copylocal: MACRO
	db $14
	db \1
	db \2
	ENDM
copybyte: MACRO
	db $15
	dd \1
	dd \2
	ENDM
setvar: MACRO
	db $16
	dw \1
	dw \2
	ENDM
addvar: MACRO
	db $17
	dw \1
	dw \2
	ENDM
subvar: MACRO
	db $18
	dw \1
	dw \2
	ENDM
copyvar: MACRO
	db $19
	dw \1
	dw \2
	ENDM
copyvarifnotzero: MACRO
	db $1A
	dw \1, \2
	ENDM
comparelocaltovalue: MACRO
	db $1C
	db \1, \2
	ENDM
compareaddrtovalue: MACRO
	db $1F
	dd \1
	db \2
	ENDM
compare: MACRO
	db $21
	dw \1, \2
	ENDM
clearflag: MACRO
	db $2A
	dw \1
	ENDM
setflag: MACRO
	db $29
	dw \1
	ENDM
checkflag: MACRO
	db $2B
	dw \1
	ENDM
getpartysize: MACRO
	db $43
	ENDM
additem: MACRO
	db $44
	dw \1, \2
	ENDM
checkitemroom: MACRO
	db $46
	dw \1, \2
	ENDM
checkitem: MACRO
	db $47
	dw \1, \2
	ENDM
checkpcitem: MACRO
	db $4A
	dw \1, \2
	ENDM
adddecoration: MACRO
	db $4b
	dw \1
	ENDM
faceplayer: MACRO
	db $5A
	ENDM
waitmsg: MACRO
	db $66
	ENDM
lock: MACRO
	db $6A
	ENDM
release: MACRO
	db $6C
	ENDM
waitkeypress: MACRO
	db $6D
	ENDM
showmonpic: MACRO
	db $75
	dw \1
	db \2
	db \3
	ENDM
hidemonpic: MACRO
	db $76
	ENDM
showcontestpainting: MACRO
	db $77
	db \1
	ENDM
braillemessage: MACRO
	db $78
	dd \1
	ENDM
brailleformat: MACRO
	db \1
	db \2
	db \3
	db \4
	db \5
	db \6
	ENDM
givemon: MACRO
	db $79
	dw \1
	db \2
	dw \3
	dd $00000000
	dd $00000000
	db $00
	ENDM
giveegg: MACRO
	db $7A
	dw \1
	ENDM
setmonmove: MACRO
	db $7b
	db \1
	db \2
	dw \3
	ENDM
checkpartymove: MACRO
	db $7c
	dw \1
	ENDM
bufferspeciesname: MACRO
	db $7d
	db \1
	dw \2
	ENDM
bufferleadmonspeciesname: MACRO
	db $7E
	db \1
	ENDM
bufferpartymonnick: MACRO
	db $7f
	db \1
	dw \2
	ENDM
bufferitemname: MACRO
	db $80
	db \1
	dw \2
	ENDM
bufferdecorationname: MACRO
	db $81
	db \1
	dw \2
	ENDM
buffermovename: MACRO
	db $82
	db \1
	dw \2
	ENDM
random: MACRO
	db $8F
	dw \1
	ENDM
setrespawn: MACRO
	db $9F
	dw \1
	ENDM
checkplayergender: MACRO
	db $A0
	ENDM
playmoncry: MACRO
	db $A1
	dw \1
	dw \2
	ENDM
setwildbattle: MACRO
	db $B6
	dw \1
	db \2
	dw \3
	ENDM
dowildbattle: MACRO
	db $B7
	ENDM
setvirtualaddress: MACRO
	db $B8
	GBAPTR \1
	ENDM
virtualgotoif: MACRO
	db $BB
	db \1
	GBAPTR \2
	ENDM
virtualmsgbox: MACRO
	db $BD
	GBAPTR \1
	ENDM
virtualloadpointer: MACRO
	db $BE
	GBAPTR \1
	ENDM
waitmoncry: MACRO
	db $C5
	ENDM
setmoneventlegal: MACRO
	db $CD
	dw \1
	ENDM
checkmoneventlegal: MACRO
	db $CE
	dw \1
	ENDM
setmonmetlocation: MACRO
	db $D2
	dw \1
	db \2
	ENDM
removemoney: MACRO
	db $91
	dd \1
	db 0
	ENDM
showmoneybox: MACRO
	db $93
	db 0
	db 0
	db 0
	ENDM
updatemoneybox: MACRO
	db $95
	db 0
	db 0
	db 0
	ENDM
hidemoneybox: MACRO
	db $94
	db 0
	db 0
	ENDM
setorcopyvar: MACRO
	db $1A
	dw \1
	dw \2
	ENDM
fadescreen: MACRO
	db $97
	db \1
	ENDM
delay: MACRO
	db $28
	dw \1
	ENDM
playse: MACRO
	db $2f
	dw \1
	ENDM
waitse: MACRO
	db $30
	ENDM
playfanfare: MACRO
	db $31
	dw \1
	ENDM
waitfanfare: MACRO
	db $32
	ENDM
playbgm: MACRO
	db $33
	dw \1
	db \2
	ENDM
fadedefaultbgm: MACRO
	db $35
	ENDM
closemessage: MACRO
	db $68
	ENDM
yesnobox: MACRO
	db $6e
	db \1
	db \2
	ENDM
createvobject: MACRO
	db $aa
	db \1 ; GFX Id
	db \2 ; Object Id
	dw \3 ; X
	dw \4 ; Y
	db \5 ; Elevation
	db \6 ; Direction
	ENDM
applymovement: MACRO
	db $4F
	dw \1 ; Object Id
	dd \2 ; Movement pointer
	ENDM
waitmovement: MACRO
	db $51
	dw \1 ; Object Id
	ENDM
checkmoney: MACRO
	db $92
	dd \1
	db 0
	ENDM
waitstate: MACRO
	db $27
	ENDM
vgoto: MACRO
	db $B9
	GBAPTR \1
	ENDM
giveitem: MACRO
	setorcopyvar VAR_0x8000, \1
	setorcopyvar VAR_0x8001, \2
	callstd STD_OBTAIN_ITEM
	ENDM
removeitem: MACRO
	db $45
	dw \1 ; Item ID
	dw \2 ; Quantity
	ENDM
dotimebasedevents: MACRO
	db $2d
	ENDM
getplayerxy: MACRO
	db $42
	dw \1 ; VAR X
	dw \2 ; VAR Y
	ENDM
randomitem: MACRO
	db $00
	db $00
	db $FF
	db $B5
	db $1F
	db $48
	db $00
	db $68
	db $1F
	db $49
	db $40
	db $18
	db $02
	db $30
	db $06
	db $1C
	db $40
	db $B4
	db $20
	db $49
	db $80
	db $20
	db $C0
	db $01
	db $01
	db $30
	db $7B
	db $46
	db $05
	db $33
	db $9E
	db $46
	db $08
	db $47
	db $00
	db $25
	db $01
	db $28
	db $02
	db $D1
	db $06
	db $25
	db $00
	db $24
	db $0E
	db $E0
	db $02
	db $28
	db $02
	db $D1
	db $10
	db $25
	db $0E
	db $24
	db $09
	db $E0
	db $03
	db $28
	db $02
	db $D1
	db $08
	db $25
	db $32
	db $24
	db $04
	db $E0
	db $04
	db $28
	db $02
	db $D1
	db $04
	db $25
	db $46
	db $24
	db $FF
	db $E7
	db $40
	db $BC
	db $36
	db $19
	db $40
	db $B4
	db $0E
	db $48
	db $7B
	db $46
	db $05
	db $33
	db $9E
	db $46
	db $00
	db $47
	db $29
	db $1C
	db $0C
	db $4A
	db $7B
	db $46
	db $05
	db $33
	db $9E
	db $46
	db $10
	db $47
	db $02
	db $25
	db $68
	db $43
	db $10
	db $BC
	db $24
	db $18
	db $06
	db $4E
	db $80
	db $20
	db $C0
	db $01
	db $21
	db $88
	db $7D
	db $46
	db $05
	db $35
	db $AE
	db $46
	db $30
	db $47
	db $FF
	db $BD
	db $8C
	db $5D
	db $00
	db $03
	db $98
	db $35
	db $00
	db $00
	db $B1
	db $D6
	db $09
	db $08
	db $CD
	db $F5
	db $06
	db $08
	db $E1
	db $7B
	db $2E
	db $08
	db $95
	db $D6
	db $09
	db $08
	ENDM

gulpintable: MACRO
	dw $FF69
	dw SMOKE_BALL
	dw EVERSTONE
	dw ORAN_BERRY
	dw SUPER_REPEL
	dw LEMONADE
	dw ETHER
	dw ITEM_NONE			; UNCOMMON
	dw SITRUS_BERRY
	dw UP_GRADE
	dw DRAGON_SCALE
	dw DEEPSEASCALE
	dw DEEPSEATOOTH
	dw METAL_COAT
	dw QUICK_CLAW
	dw ELIXIR
	dw MAX_ETHER
	dw SUN_STONE
	dw MOON_STONE
	dw FIRE_STONE
	dw THUNDERSTONE
	dw WATER_STONE
	dw LEAF_STONE
	dw STARDUST
	dw MAX_REVIVE
	dw ITEM_NONE			; RARE
	dw WHITE_HERB
	dw SHELL_BELL
	dw KING_S_ROCK
	dw LUXURY_BALL
	dw SOOTHE_BELL
	dw LEFTOVERS
	dw HEART_SCALE
	dw MAX_ELIXIR
	dw NUGGET
	dw ITEM_NONE			; ULTRA RARE
	dw LUCKY_EGG
	dw AMULET_COIN
	dw EXP_SHARE
	dw MASTER_BALL
	dw RARE_CANDY
	dw ITEM_NONE
	ENDM
vblankhijack: MACRO
	db $00
	db $00
	db $01
	db $48
	db $02
	db $49
	db $01
	db $60
	db $70
	db $47
	db $CC
	db $1B
	db $00
	db $03
	db $71
	db $A1
	db $01
	db $02
	ENDM
writedata: MACRO
	db $1E
	db $20
	db $01
	db $49
	db $01
	db $4A
	db $10
	db $47
	db $64
	db $00
	db $00
	db $02
	db $41
	db $54
	db $12
	db $08
	ENDM
readdata: MACRO
	db $1E
	db $20
	db $01
	db $49
	db $01
	db $4A
	db $10
	db $47
	db $20
	db $A0
	db $01
	db $02
	db $F9
	db $5B
	db $12
	db $08
	ENDM