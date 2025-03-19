INCLUDE "../macros.asm"
INCLUDE "../constants/items.asm"
INCLUDE "../constants/scriptcommands.asm"
INCLUDE "../constants/pokemon.asm"
INCLUDE "../constants/moves.asm"
INCLUDE "../constants/gxcomm_data.asm"
INCLUDE "../constants/gxcomm_r1.asm"
INCLUDE "../constants/gxcomm.asm"

	Mystery_Event

	db CHECKSUM_CRC
	dd 0 ; checksum placeholder
	GBAPTR DataStart
	GBAPTR DataEnd

DataStart:
	db IN_GAME_SCRIPT
	db 14, 7	; Mossdeep City - Steven's House
	db 2		; Item Ball (Beldum)
	GBAPTR GXCommInitScriptStart
	GBAPTR GXCommInitScriptEnd

	db MIX_RECORDS_ITEM
	db 1  ; ???
	db 30
	dw EON_TICKET

	db PRELOAD_SCRIPT
	GBAPTR PreloadScriptStart

	db END_OF_CHUNKS

GXCommInitScriptStart:
	setvirtualaddress GXCommInitScriptStart
	killscript
	end

GXCommInitScriptEnd:
PreloadScriptStart:
	setvirtualaddress PreloadScriptStart
	virtualloadpointer Done
	setvar VAR_UNUSED_0x40CA, 0		; Set preload script version
	callnative $02000055 ; asmstore
	setbyte 2
	end

	db $00 ; Alignment
	; 0x02000054
IF DEF(_BASE)
	asmstore						; Store below data into memory
ELIF DEF(_REV1)
	asmstore_r1
ELIF DEF(_REV2)
	asmstore_r1
ENDC

; 0x02000064
IF DEF(_RUBY)
	gxmons_r						; Pokémon & TM Table [0x150]
ELIF DEF(_SAPPHIRE)
	gxmons_s						; Pokémon & TM Table [0x150]
ENDC

IF DEF(_BASE)
	gxcomm						; Store below data into memory
ELIF DEF(_REV1)
	gxcomm_r1
ELIF DEF(_REV2)
	gxcomm_r1
ENDC

Done:
	Text_EN "GX COMM. V1 initialized.@"

DataEnd:
	EOF