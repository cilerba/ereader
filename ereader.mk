CARD_ID			?=
VERSION 		?=
REGION			?=
CARD_NAME		= $(CARD_ID)_$(VERSION)
FILE_NAME		= $(CARD_NAME)-$(REGION)

CARD_ASM		= card
SCRIPT_ASM		= script
PROLOGUE_ASM	= prologue

all: $(FILE_NAME).raw sav

$(SCRIPT_ASM)-%.tx: $(SCRIPT_ASM).asm
	python ../scripts/regionalize.py $< $@ $* $*
$(SCRIPT_ASM)-%.o: $(SCRIPT_ASM)-%.tx	
	../tools/rgbasm -o $@ $<
$(SCRIPT_ASM)-%.gbc: $(SCRIPT_ASM)-%.o
	../tools/rgblink -o $@ $<
$(SCRIPT_ASM)-%.bin: $(SCRIPT_ASM)-%.gbc
	python ../scripts/stripgbc.py $< $@
$(SCRIPT_ASM)-%.mev: $(SCRIPT_ASM)-%.bin
	python ../scripts/checksum.py $< $@

$(PROLOGUE_ASM)-%.tx: $(PROLOGUE_ASM).asm
	python ../scripts/regionalize.py $< $@ $* $*
$(PROLOGUE_ASM)-%.o: $(PROLOGUE_ASM)-%.tx
	../tools/rgbasm -o $@ $<
$(PROLOGUE_ASM)-%.gbc: $(PROLOGUE_ASM)-%.o
	../tools/rgblink -o $@ $<
$(PROLOGUE_ASM)-%.bin: $(PROLOGUE_ASM)-%.gbc
	python ../scripts/stripgbc.py $< $@

$(CARD_NAME)-%.tx: card.asm $(SCRIPT_ASM)-%.mev $(PROLOGUE_ASM)-%.bin
	python ../scripts/ereadertext.py $< $@ $*
$(CARD_NAME)-%.o: $(CARD_NAME)-%.tx
	../tools/rgbasm -o $@ $<
$(CARD_NAME)-%.gbc: $(CARD_NAME)-%.o
	../tools/rgblink -o $@ $<
$(CARD_NAME)-%.z80: $(CARD_NAME)-%.gbc
	python ../scripts/stripgbc.py $< $@
$(CARD_NAME)-%.vpk: $(CARD_NAME)-%.z80
	../tools/nevpk -c -i $< -o $@
$(CARD_NAME)-%.raw: $(CARD_NAME)-%.vpk
	../tools/nedcmake -i $< -o $(FILE_NAME) -type 1 -region 1

sav:
	../tools/nedcenc -d -i $(FILE_NAME)-01.raw -o $(FILE_NAME)-01.bin
ifeq (,$(wildcard $(FILE_NAME)-02.raw))
	../tools/nedcenc -d -i $(FILE_NAME)-02.raw -o $(FILE_NAME)-02.bin
	../tools/vpktool -i $(FILE_NAME)-01.bin -i2 $(FILE_NAME)-02.bin -o $(FILE_NAME).sav
else
	../tools/vpktool -i $(FILE_NAME)-01.bin -o $(FILE_NAME).sav
endif
	rm -f $(FILE_NAME)-01.bin $(FILE_NAME)-02.bin

clean:
	rm -f *.tx *.o *.gbc *.z80 *.bin *.mev *.raw *.vpk *.sav