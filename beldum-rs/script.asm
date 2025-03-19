INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommands.asm"
INCLUDE "../constants/pokemon.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 14, 07	; Mossdeep City - Steven's House
	db 2		; Item Ball (Beldum)
	GBAPTR BeldumScriptStart
	GBAPTR BeldumScriptEnd

	db MIX_RECORDS_ITEM
	db 1  ; ???
	db 30
	dw EON_TICKET

	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS

BeldumScriptStart:
	setvirtualaddress BeldumScriptStart
	vgoto .begin
	beldumscript
.begin
	lock
	virtualmsgbox BeldumTextCheckedBall
	waitmsg
	yesnobox 22, 8
	compare LASTRESULT, FALSE
	virtualgotoif EQUAL, BeldumTextRefusal
	getpartysize
	compare LASTRESULT, 6
	virtualgotoif EQUAL, BeldumTextNoRoom
	copyvar VAR_0x8004, LASTRESULT
	db $53, $02 ; removeobject 2
	playfanfare MUS_OBTAIN_ITEM
	virtualmsgbox BeldumTextObtain
	waitfanfare
	waitmsg
	givemon BELDUM, 5, ITEM_NONE
	callnative $02028DD7
	setflag FLAG_HIDE_BELDUM_BALL_STEVENS_HOUSE
	setflag FLAG_RECEIVED_BELDUM
	release
	end

BeldumTextCheckedBall:
	Text_EN "\v1 checked the POKé BALL.\p"

	Text_EN "It contained the POKéMON\n"
	Text_EN "BELDUM.\p"

	Text_EN "Take the POKé BALL?@"

BeldumTextRefusal:
	Text_EN "\v1 left the POKé BALL where\n"
	Text_EN "it was.@"

BeldumTextNoRoom:
	Text_EN "There is no space for another POKéMON.@"

BeldumTextObtain:
	Text_EN "\v1 obtained STEVEN’s BELDUM.@"

BeldumScriptEnd:

PreloadScriptStart:
	setvirtualaddress PreloadScriptStart

	virtualloadpointer Done
	setbyte 2
	end

Done:
	Text_EN "May our paths cross some day.\n"
	Text_EN "STEVEN STONE@"

DataEnd:
	EOF