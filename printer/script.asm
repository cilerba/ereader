INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommands.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 11, 01	; Devon Corporation
	db 1		; Scientist ("Talk to Pokémon")
	GBAPTR PrinterScriptStart
	GBAPTR PrinterScriptEnd

	db MIX_RECORDS_ITEM
	db 1  ; ???
	db 30
	dw EON_TICKET


	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS

PrinterScriptStart:
	setvirtualaddress PrinterScriptStart

	lock
	faceplayer
	
	virtualmsgbox Intro
	waitmsg
	waitkeypress
	
	showmoneybox

	virtualmsgbox AskMoney
	waitmsg
	yesnobox 22, 8
	compare LASTRESULT, FALSE
	virtualgotoif EQUAL, Goodbye
	
	checkmoney $00002710
	compare LASTRESULT, FALSE
	virtualgotoif EQUAL, NoMoney

	removemoney $00002710
	updatemoneybox
	playse SE_SHOP
	waitse

	virtualmsgbox TakeMoney
	waitmsg
	waitkeypress
	closemessage
	hidemoneybox
	delay 10
	
	copybyte $03005d80, $030022E0		; Seed RNG using gMain.vBlankCounter1... I think
	copybyte $03005d81, $030022E1
	copybyte $03005d82, $030022E2
	copybyte $03005d83, $030022E3

	setvar VAR_TEMP_2, $A ; Loop counter
	fadescreen FADE_TO_BLACK
	delay 30
	playmoncry $0E9, 0 ; PORYGON2
	waitmoncry
	playbgm MUS_RG_TEACHY_TV_MENU, FALSE
	
DoPrint:
	random 50

	copyvar VAR_TEMP_3, LASTRESULT
	addvar VAR_TEMP_3, TM01
	bufferitemname STR_VAR_1, VAR_TEMP_3
	copyvar VAR_0x8004, VAR_TEMP_3
	additem VAR_TEMP_3, 1
	
	
	db $25		; special
	dw $019E	; BufferTMHMMoveName
	compare LASTRESULT, FALSE
	virtualgotoif NOT_EQUAL, .msgsuccess
	virtualmsgbox AddFail
	playse SE_FAILURE
	goto .aftermsg
.msgsuccess
	virtualmsgbox AddSuccess
	playse SE_SUCCESS
.aftermsg
	waitmsg
	waitkeypress

	subvar VAR_TEMP_2, 1
	
	compare VAR_TEMP_2, 0
	virtualgotoif NOT_EQUAL, DoPrint
	closemessage
	fadedefaultbgm
	fadescreen FADE_FROM_BLACK

	virtualmsgbox Continue
	waitmsg
	yesnobox 22, 8
	compare LASTRESULT, FALSE
	virtualgotoif EQUAL, Kill

Goodbye:
	virtualmsgbox GoodbyeText
	waitmsg
	waitkeypress
	closemessage
	hidemoneybox
	release
	end

Kill:
	virtualmsgbox Shutdown
	waitmsg
	waitkeypress
	closemessage
	release
	killscript

NoMoney:
	virtualmsgbox NotEnough
	waitmsg
	waitkeypress
	closemessage
	hidemoneybox
	release
	end

Intro:
	Text_EN "I wrote a new software called the\n"
	Text_EN "PORY PRINTER!\p"

	Text_EN "It flashes TECHNICAL MACHINE discs\n"
	Text_EN "faster than a NINJASK!@"

Shutdown:
	Text_EN "Roger that.\n"
	Text_EN "Shutting down PORY PRINTER.@"

Continue:
	Text_EN "Would you like me to keep the\n"
	Text_EN "PORY PRINTER running?@"

GoodbyeText:
	Text_EN "Take care!@"

AskMoney:
	Text_EN "Would you like to give it a go\n"
	Text_EN "for $10,000?@"

AddFail:
	Text_EN "\v2 \v3 flashed!\nFull pocket detected…@"

AddSuccess:
	Text_EN "\v2 \v3 flashed!\nTM successfully added!@"

TakeMoney:
	Text_EN "Thank you kindly.\n"
	Text_EN "Come on out, PORYGON2!@"

NotEnough:
	Text_EN "I’m sorry. Server expenses are costly.\p"
	Text_EN "Please come back when you have enough\n"
	Text_EN "money.@"

PrinterScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart

	virtualloadpointer Done
	setbyte 2
	end

Done:
	Text_EN "The PORY PRINTER is now ready!\p"
	Text_EN "Visit the DEVON CORPORATION to\n"
	Text_EN "get started!@"

DataEnd:
	EOF