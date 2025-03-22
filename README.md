# Cilerba's Custom Pokémon e-Reader Cards
A repository of custom e-Reader cards based on [Artrios](https://github.com/Artrios)'s [pokecarde](https://github.com/Artrios/pokecarde/tree/emerald) currently only for English Pokémon Emerald.

## Available Cards

### GX COMM. (Ruby & Sapphire)
A Mass Outbreak overhaul inspired by Pokémon GO Community Day events. Speak witb Lanette after scanning the INIT card first and then the regular card that matches your game and revision. 

### Gluttonous Gulpin
A recreation of Pokémon Scarlet and Violet: Indigo Disk DLC's Item Printer. This event can be found in Fortree City's House #3 just above the Gym.

The NPC in the house will ask you if you'd like to see their Gulpin's "cool trick," which will cost you a shard of any color. This color is rolled once a day when interacting with this NPC and remains set until the following day's re-roll.

> This is done by setting unused variable and flags in the game. Specifically VAR_UNUSED_0x40FF and FLAG_UNUSED_0x920 which is a daily flag.

Drop table can be found in `docs/gulpindrops.md`


### Pory Printer
An event similar to Gluttonous Gulpin that flashes and dispenses TM discs (ranging from 1-50) in exchange for $10,000. This can be found in the Devon Corporation building in Rustboro City on the second floor.

This event does not utilize any unused variables, flags, or save block data. Every TM should have an equal chance at being distributed as there are no tiers implemented.


## How to use

To get started you'll need the `.raw` files found in Releases. When the files have finished downloading, please refer to [imablisy's video](https://www.youtube.com/watch?v=fK-Actf6kME) on how to unlock Mystery Event in Pokémon Emerald. If you have any questions please contact me on Discord or Twitter (cilerba on both).

> Further documentation needed

## Building

Please refer to the pokecarde repository linked above for instructions on building.

Assembling the scripts found in `asm/` can be done with the following command:

    arm-none-eabi-as [input] -o [output] -mcpu=arm7tdmi -mthumb
 
## Credits

 - blisy - Research, source code reference, and programming assistance
 - pret - Pokémon Emerald decompilation and programming assistance
 - Artrios & Háčky - pokecarde
