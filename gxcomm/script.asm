INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommands.asm"
INCLUDE "../constants/pokemon.asm"
INCLUDE "../constants/moves.asm"
INCLUDE "../constants/gxcomm_data.asm"
INCLUDE "../constants/gxcomm_r.asm"
INCLUDE "../constants/gxcomm_r_r1.asm"
INCLUDE "../constants/gxcomm_r_r2.asm"
INCLUDE "../constants/gxcomm_s.asm"
INCLUDE "../constants/gxcomm_s_r1.asm"
INCLUDE "../constants/gxcomm_s_r2.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 20, 02	; Route 114 - Lanette’s House
	db 1		; Lanette
	GBAPTR GXCommScriptStart
	GBAPTR GXCommScriptEnd

	db MIX_RECORDS_ITEM
	db 1  ; ???
	db 30
	dw EON_TICKET

	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS

GXCommScriptStart:
	setvirtualaddress GXCommScriptStart
	vgoto .begin
	
	vblankhijack
IF DEF(_RUBY)
	IF DEF(_BASE)
		asmread_r
	ELIF DEF(_REV1)
		asmread_r_r1
	ELIF DEF(_REV2)
		asmread_r_r2
	ENDC
ELIF DEF(_SAPP)
	IF DEF(_BASE)
		asmread_s
	ELIF DEF(_REV1)
		asmread_s_r1
	ELIF DEF(_REV2)
		asmread_s_r2
	ENDC
ENDC

	Text_EN "GX OUTBREAK\nMINUTES: \v2@"

	; laziness below

	; gxCopyGift 0x02028E11 [14]
	db $02,$48,$00,$88,$02,$49,$08,$80,$70,$47,$00,$00,$06,$85,$02,$02,$0C,$6C,$02,$02
	
.begin
	lock
	faceplayer
	compareaddrtovalue $02026C08, 255
	virtualgotoif EQUAL, .gift
	compareaddrtovalue $0201A181, 32
	virtualgotoif NOT_EQUAL, .gift

	bufferspeciesname 0, VAR_UNUSED_0x40C8
	virtualmsgbox LanetteActive
	waitmsg
	waitkeypress
	vgoto .endScript
.gift
	callnative $02028E11
	compare VAR_UNUSED_0x40CC, 0
	virtualgotoif TRUE, .dailyCheck
	virtualmsgbox LanetteGift
	waitmsg
	waitkeypress
	giveitem VAR_UNUSED_0x40CC, 3
	setvar VAR_UNUSED_0x40CC, 0
	writebytetoaddr $0, $02028506
	writebytetoaddr $0, $02028507
	vgoto .endScript
.dailyCheck
	dotimebasedevents
	checkflag FLAG_DAILY_UNKNOWN_8C3
	virtualgotoif FALSE, .inactive
	virtualmsgbox LanetteNoSignal
	waitmsg
	waitkeypress
	vgoto .clearData
.inactive
	virtualmsgbox LanetteGreeting
	waitmsg
	waitkeypress
	virtualmsgbox LanetteAskWillow
	waitmsg
	yesnobox 22, 8
	compare LASTRESULT, FALSE
	virtualgotoif EQUAL, .goodbye

	callnative $02028DE9 ; readdata
	callnative $0201A3D1 ; gxSelectMon
	callnative $0201A431 ; gxInit
	copybyte $02028506, $02026C0A
	copybyte $02028507, $02026C0B
	setflag FLAG_DAILY_UNKNOWN_8C3

IF DEF(_RUBY)
	IF DEF(_BASE)
		callscr $0819f806 ; Common_EventScript_SaveGame
	ELIF DEF(_REV1)
		callscr $0819f826 ; Common_EventScript_SaveGame
	ELIF DEF(_REV2)
		callscr $0819f826 ; Common_EventScript_SaveGame
	ENDC
ELIF DEF(_SAPP)
	IF DEF(_BASE)
		callscr $0819f796 ; Common_EventScript_SaveGame
	ELIF DEF(_REV1)
		callscr $0819f7b6 ; Common_EventScript_SaveGame
	ELIF DEF(_REV2)
		callscr $0819f7b6 ; Common_EventScript_SaveGame
	ENDC
ENDC
	compare LASTRESULT, FALSE
	virtualgotoif EQUAL, .clearFlag
	

	virtualmsgbox LanetteAskWillow_Yes
	waitmsg
	waitkeypress
	closemessage
	playse 4 ; SE_PC_ON
	waitse
	callnative $02028DD9 ; vblankHijack
	bufferspeciesname 0, VAR_UNUSED_0x40C8
	buffermovename 1, VAR_UNUSED_0x40C9
	virtualmsgbox LanetteCallWillow
	waitmsg
	waitkeypress
	playse 3 ; SE_PC_OFF
	waitse
	virtualmsgbox LanetteLuck
	vgoto .endScript
.clearFlag
	clearflag FLAG_DAILY_UNKNOWN_8C3
.clearData
	setvar VAR_UNUSED_0x40C8, $0
	setvar VAR_UNUSED_0x40C9, $0
	setvar VAR_UNUSED_0x40CA, $0
	setvar VAR_UNUSED_0x40CB, $0
	writebytetoaddr 0, $02028506
	writebytetoaddr 0, $02028507
.goodbye
	virtualmsgbox LanetteAskWillow_No
	waitmsg
	waitkeypress
.endScript
	release
	end

LanetteGreeting:
	Text_EN "LANETTE: Hi, \v1!@"

LanetteAskWillow:
	Text_EN "Would you like to call PROF. WILLOW\n"
	Text_EN "to look for an outbreak?@"

LanetteAskWillow_No:
	Text_EN "LANETTE: See you around!@"

LanetteAskWillow_Yes:
	Text_EN "Perfect! Let’s give him a ring\n"
	Text_EN "using the GX COMM.@"

LanetteCallWillow:
	Text_EN "… … …\p"

	Text_EN "WILLOW: Hello? LANETTE?\p"

	Text_EN "Hi there! I’m seeing lots of wild\n"
	Text_EN "\v2.\p"

	Text_EN "I’m even seeing some that have\n"
	Text_EN "learned \v3!\p"

	Text_EN "That’s all I’ve got!\n"
	Text_EN "Bye LANETTE!@"

LanetteAskWillow_After:
	Text_EN "LANETTE: See you around!@"

LanetteLuck:
	Text_EN "LANETTE: Good luck, \v1!@"

LanetteActive:
	Text_EN "LANETTE: Have you found any\n"
	Text_EN "wild \v2?\p"

	Text_EN "Keep searching, \v1!@"

LanetteNoSignal:
	Text_EN "LANETTE: Hi, \v1!\p"

	Text_EN "My GX. COMM doesn’t seem to be\n"
	Text_EN "picking up any signal…\p"

	Text_EN "Try back again tomorrow.@"

LanetteGift:
	Text_EN "LANETTE: Hi, \v1!\p"

	Text_EN "It looks like a gift came in\n"
	Text_EN "for you!@"

GXCommScriptEnd:
PreloadScriptStart:
	setvirtualaddress PreloadScriptStart
	virtualloadpointer Done
	setbyte 2
	end

Done:
	Text_EN "The GX COMM. device has been\n"
	Text_EN "completed! Go see LANETTE.@"

DataEnd:
	EOF