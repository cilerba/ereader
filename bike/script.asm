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
	db 10, 1	; Bike Shop
	db 2		; NPC
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
	
	checkitem MACH_BIKE, 1
	virtualgotoif FALSE, .giveMach
	giveitem ACRO_BIKE, 1
	vgoto .givenBike
.giveMach
	giveitem MACH_BIKE, 1
.givenBike
	closemessage
	release
	killscript
	end

Intro:
	Text_EN "That guy only gave you one\n"
	Text_EN "bicycle?\p"

	Text_EN "Nonsense! Take this.@"

PrinterScriptEnd:


PreloadScriptStart:
	setvirtualaddress PreloadScriptStart

	virtualloadpointer Done
	setbyte 2
	end

Done:
	Text_EN "Go get that bike.@"

DataEnd:
	EOF