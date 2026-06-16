# Prince of Persia 2 Special Events

*overview for amateur mod creators*

July 10, 2014

> [!NOTE]
> This document is a faithful Markdown conversion of the **Prince of Persia 2
> Special Events** PDF (2nd version, July 10, 2014) by the Prince of Persia
> modding community. The original is published at
> [popot.org](https://www.popot.org/documentation/documents/2014-07-10_PoP2_Special_Events.pdf).
> Like the original, this document is licensed under the GNU Free Documentation
> License (see [License](#license)).

## Contents

- [Preamble](#preamble)
- [License](#license)
- [For All Levels](#for-all-levels)
- [1. Level 1](#1-level-1)
  - [1.1 Room 4](#11-room-4)
  - [1.2 Room 11](#12-room-11)
  - [1.3 Room 15](#13-room-15)
  - [1.4 Room 16](#14-room-16)
  - [1.5 Room 19](#15-room-19)
- [2. Level 2](#2-level-2)
  - [2.1 All Rooms](#21-all-rooms)
  - [2.2 Room 1](#22-room-1)
  - [2.3 Room 2](#23-room-2)
  - [2.4 Room 3](#24-room-3)
- [3. Level 3](#3-level-3)
- [4. Level 4](#4-level-4)
- [5. Level 5](#5-level-5)
  - [5.1 Room 3](#51-room-3)
  - [5.2 Room 7](#52-room-7)
  - [5.3 Room 10](#53-room-10)
  - [5.4 Room 12](#54-room-12)
  - [5.5 Room 16](#55-room-16)
- [6. Level 6](#6-level-6)
  - [6.1 Room 27](#61-room-27)
- [7. Level 7](#7-level-7)
  - [7.1 Room 3](#71-room-3)
- [8. Level 8](#8-level-8)
  - [8.1 Room 9](#81-room-9)
  - [8.2 Room 12](#82-room-12)
- [9. Level 9](#9-level-9)
  - [9.1 Room 2](#91-room-2)
  - [9.2 Room 8](#92-room-8)
  - [9.3 Room 16](#93-room-16)
- [10. Level 10](#10-level-10)
  - [10.1 Room 22](#101-room-22)
- [11. Level 11](#11-level-11)
  - [11.1 Room 6](#111-room-6)
- [12. Level 12](#12-level-12)
  - [12.1 Room 2](#121-room-2)
  - [12.2 Room 11](#122-room-11)
  - [12.3 Room 19](#123-room-19)
- [13. Level 13](#13-level-13)
  - [13.1 Room 2](#131-room-2)
  - [13.2 Room 4](#132-room-4)
  - [13.3 Room 13](#133-room-13)
  - [13.4 Room 32](#134-room-32)
- [14. Level 14](#14-level-14)
  - [14.1 Room 1](#141-room-1)
  - [14.2 Room 2](#142-room-2)
  - [14.3 Room 3](#143-room-3)
  - [14.4 Room 4](#144-room-4)
  - [14.5 Room 5](#145-room-5)
  - [14.6 Room 6](#146-room-6)
  - [14.7 Rooms 7 and 8](#147-rooms-7-and-8)
- [Afterword](#afterword)
- [Credits](#credits)


## Preamble

This document describes all the special events that take place in Prince of Persia 2, when they are triggered and at what locations. It is possible to customize these events by altering the PRINCE.EXE file. This document describes the characteristics of the events when aforementioned file has not been changed. This knowledge can be used to change levels in such a way that the events still take place, but with different results or at (seemingly) different locations.

This is the second version of this document, so there is still room for improvement. In case you find a mistake or have a suggestion, please let us know.1

No

tes:

- Xpos is measured the same way as for guards: 144=left edge, 464=right edge of the room.

- "VERIFIED" means that when hex-editing the room number at or around the mentioned location, the special event changes or disappears. If a line is not marked as such: ◦if there is an offset, then it's a guess based on the disassembly, ◦if there is no offset, then it's an observation based on playing the game.

## License

Copyright © 2014 Prince of Persia modding community

Permission is granted to copy, distribute and/or modify this document under the terms of the GNU Free Documentation License, Version 1.3 or any later version published by the Free Software Foundation; with no Invariant Sections, no Front-Cover Texts, and no Back-Cover Texts.

1 http://forum.princed.org/viewtopic.php?f=73&t=3497

## For All Levels

When entering a level, all tunnels are automatically closed. Also true for exit doors.

## 1. Level 1

In various rooms (1-5, 10-12, 15, 16 and 19), custom boardwalk and palace graphics are shown. Rooms on the ground level use a different palette.

```
seg003:1AC2 dead kid/guard disappears on rooftops, except where otherwise noted
Because you don't see them anyway behind the ledge.
seg030:0633 kid/guard splats after falling (ypos>384), except where otherwise noted
(no offset yet) Guard's 1 HP doesn't blink, unless you come here from level 14 with alt-
N.
```

### 1.1 Room 4

- When the prince first enters this room, a window breaks.

- If the prince starts in this room, he moves five tiles to the right and a little bit downward. This means that, if the prince does not make a falling start, he gets vertically misaligned. The prince starts with a running jump but skips 9 frames before displaying one.

```
seg011:0222 [VERIFIED] if starting here: falling entry
(tile type 0x27) when kid enters here first: breaking window
```

### 1.2 Room 11

If the prince leaves downward, the player keeps seeing room 11.

```
seg030:1748 [VERIFIED] don't follow down
seg032:0316 [VERIFIED] falling 2 rows + landing below the room = die (instead of -1
HP) (row>=3)
```

### 1.3 Room 15

- If the prince leaves to the right, the player keeps seeing room 15. If the prince keeps going right, the player hears him being murdered.

- The prince cannot climb up.

- The prince can climb down, but in a strange way and leaving downward kills the prince.

- There is a checkpoint on the 6th tile from the upper left, set in the PRINCE.DAT levels file.

```
seg003:1520 [VERIFIED] can climb from row 0, but not from other rows
```

```
seg006:07A0 ??? drawing custom images
seg010:005D [VERIFIED] kid doesn't scream
seg030:1719 [VERIFIED] don't follow to the right + killed if goes right
seg032:13BD [VERIFIED] jump up as if there was nothing above
seg032:147F [VERIFIED] hang against wall
seg003:1AD7 [VERIFIED] dead kid/guard does not disappear
OVL_04/L00000145 [VERIFIED] load other palette
OVL_04/L000001E3 [VERIFIED] water palette animation
OVL_04/L0000023E [VERIFIED] (kid is past right edge and xpos>513) killed if goes right (Note: room number is not checked here, only xpos)
```

### 1.4 Room 16

If the prince touches any tile on the bottom row, he dies.

```
seg003:0DFB [VERIFIED] kid/guard doesn't splat after falling (ypos>384)
seg006:0799 ??? drawing custom images
seg006:07BA ??? drawing custom images
seg010:0057 kid doesn't scream?
seg030:064A guard doesn't splat?
seg003:1AD0 [VERIFIED] dead kid/guard does not disappear
OVL_04/L000000BC (CUST 0x12) [VERIFIED] splash when kid/guard falls, dies in bottom row
OVL_04/L0000013F [VERIFIED] load other palette
OVL_04/L00000197 [VERIFIED] kid is clipped at bottom at y=172
OVL_04/L000001DC [VERIFIED] water palette animation
OVL_04/L000003BF [VERIFIED] kid splash
OVL_04/L00000447 [VERIFIED] guard splash (ypos>=172)
OVL_04/L0000049A (CUST 0x12) [VERIFIED] if someone is in the bottom row: start splash
OVL_04/L000007EC [VERIFIED] (tile type 0x25) animated water on pillar
OVL_12/L0000010A [VERIFIED] guards fall off the bridge when they die
```

### 1.5 Room 19

- If the prince touches any tile on the bottom row, he dies.

- When the prince first enters this room, a ship leave to the left. If the prince grabs and holds onto the ship's window, level 2 starts.

```
seg003:0DF4 [VERIFIED] kid/guard doesn't splat after falling (ypos>384)
seg006:0792 ??? drawing custom images
seg006:07B3 ??? drawing custom images
seg010:0051 kid doesn't scream?
seg030:0643 guard doesn't splat?
```

```
seg003:1AC9 [VERIFIED] dead guard/kid does not disappear
OVL_04/L000000C2 (CUST 0x13) [VERIFIED] splash when kid/guard falls, dies in bottom row
OVL_04/L00000139 [VERIFIED] load other palette
OVL_04/L00000190 [VERIFIED] kid is clipped at bottom at y=172
OVL_04/L000001D5 [VERIFIED] water palette animation
OVL_04/L000003B8 [VERIFIED] if hanging, go with ship + kid splash (ypos>=172)
OVL_04/L000003D6 [VERIFIED] when hanging in row 0 or 1: go with ship + play music
OVL_04/L00000440 [VERIFIED] guard splash (ypos>=172)
OVL_04/L000004A0 (CUST 0x13) [VERIFIED] if someone is in the bottom row: start splash
OVL_04/L000007D8 [VERIFIED] (tile type 0x25) animated water on pillar
OVL_04/L00000A12 [VERIFIED] climb up onto ship
OVL_04/L00000A2E [VERIFIED] grab ship (row<3, xpos<208)
OVL_04/L00000A54 [VERIFIED] go with ship, climbing up = next level (xpos<208)
OVL_12/L00000103 [VERIFIED] guards fall off the bridge when they die
(tile type 0x26) ship
```

## 2. Level 2

In rooms 1-3, custom beach graphics are shown. If the level in a a desert level, the prince will start laying down on the ground. (Not in the DOS version:) Also, the prince can't go en garde in this level.

```
seg011:0234 [VERIFIED] start lying + stand up
(no offset yet) when climbing up or down: as if you release up/down and press shift
(no offset yet) when falling: buried in sand
Note: if kid is not in room 1, something else is drawn instead of the sand.
OVL_05/L0000001A: kid is clipped at bottom at y=126
```

### 2.1 All Rooms

- Wind-generated waves can be heard.

- Climbing up is not possible and gives a hanging animation.

- Climbing down is possible but gives a hanging animation.

- Touching columns 3-8 on any row, if there's no tile, makes the prince sink and die.

### 2.2 Room 1

- Every time the prince enters the room, all non-raised quicksand stones raise. The wind-generated waves sound effect stops, and even with ambient music turned off a tune is played.

- If all quicksand stones are down except the marked stone, the cave entrance at the far left opens.

- The first time the prince enters this room, the symbol and its location will be randomly selected.

- Leaving to the left loads level 3.

```
seg030:16F8 [VERIFIED] don't follow to the left
OVL_05/L00000121 [VERIFIED] no water palette animation in this room, only in others
OVL_05/L00000172 [VERIFIED] no sea sound in this room, only in others
OVL_05/L00000207 [VERIFIED] sandfloor sinks when kid steps on it (column 2..7)
OVL_05/L0000026E [VERIFIED] leave left: exit level (xpos<130) (Note: room number is not checked here, only xpos)
OVL_05/L0000038B: (CUST 0x06) 2.2 The first time the prince enters this room, the symbol and its location will be randomly selected.
(desert_left_proc = 29CFh:370h)
(no offset yet) door opens when all sandfloors sink
(tile type 0x1E) sandfloors
```

### 2.3 Room 2

```
(tile type 0x1D) water on raft
```

### 2.4 Room 3

If the prince leaves to the right, the player keeps seeing room 3 and hears the prince stepping on water.

```
seg030:1667 [VERIFIED] don't follow right if kid turns left?
seg030:16B3 [VERIFIED] don't follow right
OVL_05/L000002A6 [VERIFIED] walk in water sound + disable standing jump/crouch/jump up + disable run-turn from right to left (xpos>489)
(tile type 0x1C) water on rocks
```

## 3. Level 3

There are no special events in this level.

## 4. Level 4

There are running skeletons in rooms 22 and 24-28 of this level. ((room >= 22) && (room <= 28) && (room != 23)) If the level exit door is open and the prince is to the left of these skeletons, they awaken and chase the prince. Special music is then played. The prince breathes a sigh of relief when the stone door closes, but this is not a special event: it always happens when the prince just closed a gate between him and an enemy. Time starts when restarting level 4 and after completing the level.

## 5. Level 5

(Not in the DOS version.) Uses a different palette.

```
seg007:0768 load "sitting" image
seg011:0F7E Not exactly an event. Just initializing the variables for the breaking of the bridge.
```

### 5.1 Room 3

- When entering the room, custom music is played.

- Has a flying carpet, grate and other custom graphics. If the prince uses the carpet and the grate is closed, he dies; if the grate is open, he leaves upward and level 6 starts.

- If the prince leaves (climbs) upward, the player keeps seeing room 3.

- (Not in the DOS version.) Uses a different palette.

```
seg001:0897 [VERIFIED] kid sitting -> carpet goes up
seg003:1B60 A (mostly) useless check for when the prince hit the bars at the top of the room.
seg008:1803 something about modifiers after clearing the loose floor
seg030:1547 [VERIFIED] don't follow up
(without this, kid dies when the carpet reaches the top of the screen)
seg032:081C [VERIFIED] crouch on carpet -> sit on carpet
OVL_13 is loaded only if kid is in this room
(carpet_room_proc = 2DC2h:0) OVL_13/L00000000: play music 0x21=33
(RugRoom.gmf)
OVL_13/L00000428: load other palette?
(tile type 0x12) carpet
(tile type 0x1B) top hole
```

### 5.2 Room 7

```
seg003:0653 (row 1) something about flipping with sword
seg003:096F (row 1) skeleton on bridge has infinite HP
seg004:0368 ???
seg006:265F (row 1) skeleton on bridge shows no HP
seg008:0ACB something about the gate
seg008:251C load music 65 (BrgDoor.gmf) when the door is closed (col>=3)
seg008:2537 play music 65 (BrgDoor.gmf) when the door is closed (col>=3)
seg010:0620 bridge fight music 64 (BrgFight.gmf)
seg011:0880 (row 1) ??? bounds check?
seg030:11DD (row 1) ???
```

```
OVL_06/L00000133 (row 1) ???
OVL_06/L00000C01 ???
OVL_12/L000003B9 (row 1) ???
OVL_12/L00000827 (row 1) ???
OVL_12/L00000881 (row 1) ???
OVL_12/L00000BBF (row 1) ???
OVL_12/L00000C36 (row 1) ???
OVL_12/L00000C8A (row 1) ???
OVL_12/L00000CF1 (row 1) ???
OVL_12/L00000D2A (row 1) ???
OVL_12/L000010F8 (row 1) ???
OVL_14/L0000016E ???
```

### 5.3 Room 10

- The skeleton on the shaky bridge waits on the 4th tile from the left. If the skeleton is to the right of the prince: the skeleton runs to the right (to close the stone door) if he's not being hit; the bridge (tiles 4-8) collapses if the prince touches the 5th tile from the left.

- If the prince climbs up anywhere, he loses his sword.

- If the prince leaves downward, the player keeps seeing room 10 and hears the prince falling to his death.

```
seg001:0443 [VERIFIED] needed for correct drawing of collapsed bridge
seg003:064C (row 1) something about flipping with sword
seg003:0968 [VERIFIED] (row 1) skeleton on bridge has infinite HP
seg003:0ACD something about going right
seg006:0F1E something about CUST
seg006:2655 [VERIFIED] (row 1) skeleton on bridge shows no HP
seg010:0619 [VERIFIED] bridge fight music 64 (BrgFight.gmf)
seg011:0879 (row 1) ??? bounds check?
seg030:11D6 (row 1) ???
seg030:1779 [VERIFIED] don't follow down
seg030:17D7 [VERIFIED] down = scream + die
seg032:14CC [VERIFIED] when climbing up: lose sword
seg032:1C6E ??? something about shift-back?
OVL_06/L0000012C (row 1) ???
OVL_06/L00000BF3 ???
OVL_12/L000003B2 (row 1) ???
OVL_12/L00000820 (row 1) ???
OVL_12/L0000087A (row 1) ???
OVL_12/L00000BB8 (row 1) ???
OVL_12/L00000C2F (row 1) ???
OVL_12/L00000C83 (row 1) ???
OVL_12/L00000CEA (row 1) ???
```

```
OVL_12/L00000D23 (row 1) ???
OVL_12/L000010F1 (row 1) ???
OVL_14 is loaded only if kid is in this room
OVL_14/L00000110 bridge falls when 4<=Kid.col<=6 and 5<=Guard.col<=6 and
Kid.seq!=0x55 (dying) + music 0x42=66 (BrgFall.gmf)
OVL_14/L000003F3 [VERIFIED] load other palette
OVL_14/L0000055B ???
OVL_14/L00000803 ???
OVL_14/L000008BF [VERIFIED] needed for correct drawing of collapsed bridge
(caverns_bridge_proc = 2DC2h:3ECh)
(tile type 0x2C) bridge
(no offset yet) kid can turn left when the bridge collapses (or is this not special?)
(no offset yet) kid shows through floor when climbing (looking right) (bug?)
(no offset yet) skeleton wants to press the button if the door is open
(no offset yet) skeleton won't step on the middle of the bridge
(no offset yet) when jumping up from bridge, kid does not jump up as far as usual -- though this is probably because of the tiletype, not the room
```

### 5.4 Room 12

The 2nd tile in the middle row is a checkpoint, set in the PRINCE.DAT levels file.

```
seg003:065A (row 1) something about flipping with sword
seg003:0976 (row 1) skeleton on bridge has infinite HP
seg004:0376 ???
seg006:2669 (row 1) skeleton on bridge shows no HP
seg010:0627 bridge fight music 64 (BrgFight.gmf)
seg011:0887 (row 1) ??? bounds check?
seg030:11E4 (row 1) ???
OVL_06/L0000013A (row 1) ???
OVL_06/L00000C0F ???
OVL_12/L000003C0 (row 1) ???
OVL_12/L0000082E (row 1) ???
OVL_12/L00000888 (row 1) ???
OVL_12/L00000BC6 (row 1) ???
OVL_12/L00000C3D (row 1) ???
OVL_12/L00000C91 (row 1) ???
OVL_12/L00000CF8 (row 1) ???
OVL_12/L00000D31 (row 1) ???
OVL_12/L000010FF (row 1) ???
OVL_14/L00000181 ???
```

5.5 room 16

The lower left tile is a checkpoint, set in the PRINCE.DAT levels file.

## 6. Level 6

The prince starts this level without a sword.

```
seg003:04AA [VERIFIED] the two exits bring to different places of next level if (col<6) then which=1 else which=2
seg007:0C72 [VERIFIED] start without sword
```

### 6.1 Room 27

- Uses a different palette from the rest of the level.

- Leaving to the left teleports the prince to the left edge of the 5th tile in the lower left of room 3.

- The prince always starts on the 4th tile from the left.

```
seg002:00AE [VERIFIED] if kid starts the level here: seamless transition from cutscene
seg003:01BE [VERIFIED] room 0 is filled with "empty" tile (other rooms have wall, except if it's above the current room)
So kid won't hang against wall at the bottom of this room.
seg003:17D0 [VERIFIED] don't clip kid when he's climbing/hanging
seg011:0240 [VERIFIED] standing entry, set xpos=240
seg030:17AA [VERIFIED] don't follow down when climbing or hanging against wall
seg030:1815 [VERIFIED] leave left: enter the ruins
OVL_08/L000001A3: dir=right, seq=turning, room=3, col=4, row=2
(ruins_start_proc = 2A4E:01EEh) OVL_08/L000001EE: load other palette
(ruins_start_exit_proc) OVL_08/L00000202: load default palette
```

## 7. Level 7

The prince starts this level with the short sword. If the player left level 6 using a level door that is in one of the first six tiles of a row, he will start this level in room 32, on the 5th tile from the lower left. Otherwise, he will start in room 4, on the 6th tile from the lower left.

```
seg007:0C80 [VERIFIED] start with short sword
seg011:01B4 [VERIFIED] has two alternate start positions if (which=2) then room=4, tile=25 else room=32, tile=24
```

### 7.1 Room 3

The upper left tile is a checkpoint, set in the PRINCE.DAT levels file.

## 8. Level 8

The prince starts this level with the short sword.

```
seg007:0C87 [VERIFIED] start with short sword
seg008:12FC [VERIFIED] you can open the exit only if you have the long sword
Note that you can always open exit doors in the starting room, but you can never enter them. (bug?)
```

### 8.1 Room 9

- Picking up a sword gives the flashback cutscene.

- Custom music is played when entering this room.

- The 5th tile from the lower left is a checkpoint, set in the PRINCE.DAT levels file.

- Uses a different palette.

```
seg002:00D8 if kid (re)starts the level here: seamless transition from cutscene
seg006:2790 [VERIFIED] don't display the front part of the floor of the sword
Top 2 bits of modifier 2 are set to 01. That means "draw front layer only", but that is too much.
seg007:0C8E [VERIFIED] if restarting from here: start with long sword
seg011:0D95 [VERIFIED] checkpoint is activated only if you have father's sword
seg032:09E2 [VERIFIED] after shock: cutscene
seg032:0E70 something about turning around? -> Move back a little when turning around when you're behind the gate on the right.
seg032:1176 [VERIFIED] pick up sword and be shocked
seg033:029C [VERIFIED] kid bumps into gate at different x-coordinate (needed because of different perspective)
seg033:0904 something about standing up from crouch under a gate
seg033:0CB7 ???
seg033:0D7E [VERIFIED] if kid draws sword at the gate, he can go through gate to the left
OVL_08/L00000C87 ???
OVL_16 is loaded only if kid is in this room
OVL_16/L000000BD go to room 9?
(sword_room_proc = 2DC2h:1Ch)
```

### 8.2 Room 12

The 5th tile from the right in the middle row is a checkpoint, set in the PRINCE.DAT levels file.

## 9. Level 9

There are custom graphics various rooms (2, 11-16).

### 9.1 Room 2

- The white horse statue is displayed on top of any other background tiles.

- Custom music is played when first entering this room from the left.

```
seg006:229F [VERIFIED] horse image (25457), layer=0 (behind kid), pos=[22,159]
OVL_08/L00000246 play music 0x5B=91 (Horse.gmf) (only once)
(horse_chasm_proc = 2A4E:0226h)
```

### 9.2 Room 8

Leaving to the left with a running jump from the 2nd tile in the top left gives the horse riding cutscene. (This only happens with the non-cracked game and when leaving the room at a specific frame.) Then level 10 starts.

```
seg030:160C [VERIFIED] (row 0, run-jump) leave left: jump onto horse
OVL_08/L00000C87 ???
```

### 9.3 Room 16

Custom music is played in this room.

```
seg003:17BF [VERIFIED] don't clip kid when he's climbing/hanging
seg010:066D ??? something about guards?
seg030:179C [VERIFIED] don't follow down when climbing or hanging against wall
OVL_08/L0000022D when entering from right (col>=9) play music 0x5C=92
(Chasm.gmf)
(horse_chasm_proc = 2A4E:0226h)
```

## 10. Level 10

### 10.1 Room 22

- Has a horse statue.

- If the prince starts here, the color palette gets corrupted, and the prince gets horizontally centered (to a specific value) inside the room.

```
seg002:00B5 [VERIFIED] if kid starts the level here: seamless transition from cutscene (don't load palette)
seg006:13FA horse?
seg006:1F8B horse?
seg006:22DE [VERIFIED] horse image (25456), layer=1 (in front of kid), pos=[102,119]
seg011:025A [VERIFIED] standing entry, set xpos=310
```

## 11. Level 11

### 11.1 Room 6

The 3rd tile from the right in the middle row is a checkpoint, set in the PRINCE.DAT levels file.

## 12. Level 12

### 12.1 Room 2

The top right tile is a checkpoint, set in the PRINCE.DAT levels file.

### 12.2 Room 11

The left tile in the middle row is a checkpoint, set in the PRINCE.DAT levels file.

```
seg030:039B ??? something about the flaming sword?
```

### 12.3 Room 19

```
seg030:03A2 ??? something about the flaming sword?
```

## 13. Level 13

```
seg007:0770 load "flamed" images
seg007:0778 load "flaming" images
seg008:133C [VERIFIED] no "leveldoor open" music
```

(Not in IR:) In some rooms, guards may fall out of the screen when they die. (Just like on level 1, rooms 16/19) It's unknown whether this is activated by certain room numbers, or the special pillars below the floor.

### 13.1 Room 2

Displays the right part of the rightmost tile of the bottom row from the room on the left.(?)

The following only happens if the 2nd modifier has certain values (like 64, 191 or 192) or if there is no background.

- Every time the prince enters from the right on any row, a harp sound is played and then a short tune. This happens even with ambient music turned off.

- Has a "He Who Would Steal The Flame Must Die" text on the background, plus two pillars.

```
(temple_text_proc = 2A4E:0FAEh) when entering from right (col>=9) play music?
0x5C=92 (Chasm.gmf)
```

### 13.2 Room 4

- Shows a flame if the 2nd tile in the middle row is 43 (0Y11 in apoplexy).

- The level hangs unless the 3rd tile in the middle row is 0N5/183/192.

- If the prince leaves downward, the player keeps seeing room 4 and hears the prince falling to his death.

- If the prince is killed in the middle row, he becomes a flame. If the prince is too far to the left, the flamed prince keeps walking to the right and the player cannot continue playing.

```
seg000:0466 ??? shadow?
seg003:0186 [VERIFIED] room 0 is filled with "empty" tile
seg008:0CC8 [VERIFIED] no "leveldoor stopping" sound
seg008:0CE3 [VERIFIED] no "leveldoor opening" sound
seg008:1625 [VERIFIED] button has no sound
seg011:0B07 [VERIFIED] shadow animation
seg030:1780 [VERIFIED] don't follow down
```

```
seg030:17DE [VERIFIED] down = scream + die
OVL_09/L00000FC0 [VERIFIED] needed for the shadow animation
OVL_15 is loaded only if kid is in this room
OVL_15/L0000022E [VERIFIED] (row=1, xpos<=0xDA=218) If kid touches row 0, column <= 1, he'll burn. (even if the blue flame is not there!)
OVL_15/L00000268 [VERIFIED] (row=1, xpos<=0xEC=236) play music 0x3D=61
(Approach.gmf)
OVL_15/L00000288: (row=1) If kid dies, shadow jumps over to flame and picks it up.
OVL_15/L000002C8 [VERIFIED] needed for the shadow animation
Without this, nothing happens. The "PRESS ANY KEY" won't blink either.
OVL_15/L000003F8 (CUST 0x20) [VERIFIED] animate flame
OVL_15/L000005E0 ??? some rect?
(flame_room_proc = 2DC2h:4ECh)
(tile type 0x2B) blue flame
(no offset yet) Shadow hangs as if there was no wall under the ledge.
(no offset yet) After getting the flame, guards bow if kid is in the same row as them.
```

### 13.3 Room 13

If the prince leaves downward, the player keeps seeing room 13 and hears the prince falling to his death.

```
seg003:019B [VERIFIED] room 0 is filled with "empty" tile
Only for collision detection, not for drawing!
seg030:1795 [VERIFIED] don't follow down
seg030:17F3 [VERIFIED] down = scream + die
OVL_12/L0000070F (something with guards)
```

### 13.4 Room 32

The right tile in the middle row is a checkpoint, set in the PRINCE.DAT levels file.

## 14. Level 14

In various rooms (1-8), custom graphics are shown. (Not in IR:) The prince can't go en garde if he's in room 1 or 2. There's one palette for the tower rooms, one for the spider and chessboard rooms and another one for the last three rooms.

```
seg005:0CE1 can't save after level 14?
```

### 14.1 Room 1

If the prince starts here, he's horizontally centered (to a specific value) inside the room.

```
seg002:00C3 [VERIFIED] if kid starts the level here: seamless transition from cutscene
seg003:172E [VERIFIED] don't clip kid when he's climbing/hanging
seg006:0650 Fill background with blue.
seg006:13EC [VERIFIED] horse is behind the tower
seg006:1F84 [VERIFIED] horse is behind the tower
seg006:22C4 [VERIFIED] horse image (25458), layer=1 (in front of kid), pos=[37,112]
seg007:0461 something about sword (palette?)
seg011:027B [VERIFIED] standing entry, set xpos=306
(palacetop_proc = 29CF:12FEh)
```

### 14.2 Room 2

If the prince touches any tile on the first 4.5 columns of any row, the false prince cutscene is shown. Then the prince ends up in room 4, on the right edge of the 5th tile from the left, with his sword drawn, looking right.

```
OVL_10/L000004FD [VERIFIED] enter the tower (char_x_right_coll<=0x0131=305, action!=falling)
(no offset yet) Then kid is brought to room 4, (col=???) and draws his sword.
```

### 14.3 Room 3

- Guards randomly appear on the middle and bottom rows.

- The prince can leave downward and to the right, but the player keeps seeing room 3.

```
seg003:01DD about room 0
seg003:0EBD fell out? (row>=11)
seg003:0FDF something about walls? (col<0)
```

```
seg003:17DE [VERIFIED] don't clip kid when he's climbing/hanging
seg030:1736 [VERIFIED] don't follow to the right
seg030:1756 [VERIFIED] don't follow down
seg032:0634 [VERIFIED] dead guards disappear
OVL_10/L000000B6 [VERIFIED] guards may give potion when they die (3 possibilities with equal chances: no potion, small potion, big potion)
OVL_10/L000002E6 [VERIFIED] (row=1 && kid is dead) kid is clipped at bottom at y=0x0077=119
OVL_10/L00000600 [VERIFIED] guards appear (with sound) in row 1 and 2, only on rows where there is nobody, there may be no more then 2 guards at the same time.
OVL_10/L00000278 room number for new guard is set here
OVL_10/L000013A7 Music: 0x10D=269 (Spider.gmf)
OVL_10/L00001386 [VERIFIED] load potions palette (without this, potions and their bubbles will be grey)
OVL_10/L000014D0 (cust 0x19) [VERIFIED] animate spider
(spider_chess_proc = 29CF:1334h)
(tile type 0x28) spider
```

### 14.4 Room 4

The 5th tile from the left is a checkpoint, set in the PRINCE.DAT levels file.

```
OVL_10/L00000561 ???
OVL_10/L0000135B [VERIFIED] clear screen before drawing room (black background) sOVL_10/L00001456 (cust 0x1A) [VERIFIED] animate Jaffar's face
(spider_chess_proc = 29CF:1334h)
(tile type 0x1F) Jaffar's face
```

### 14.5 Room 5

The prince can leave downward, but the player keeps seeing room 5.

```
seg003:0ECB fell out? (row>=11)
seg030:1764 [VERIFIED] don't follow down
OVL_10/L00000553 [VERIFIED] if (kid is flame && kid's body is in room 7 or 8 && kid.col<=4 && kid's current frame requires floor below) then die (+ Jaffar laughs)
(spider_chess_proc = 29CF:1334h)
```

### 14.6 Room 6

If there is only one false prince, he disappears. He then shows up in room 8, on the 3rd tile from the upper right. (Not in IR:) Every time the prince enters this room, the

direction the false princes face (left or right) is randomized.

```
seg000:0BCC [VERIFIED] if (modifier[0] & 0x10) sparkle
seg003:17EC [VERIFIED] don't clip kid when he's climbing/hanging
OVL_10/L00000004 ???
OVL_10/L00001618: play music 0x10E=270 (Crystal.gmf)
OVL_10/L0000162E (CUST 0x1C) ???
(crystal_Jaffar_proc = 29CF:15A8h)
(no offset yet) If there is only one false prince left, and the kid is alive, the false prince will disappear by itself, and then appears in room 8.
(no offset yet) If kid stands near a false prince, he will turn around many times.
(no offset yet) If kid turns his back towards a false prince, and runs of steps, then that false prince will (try to) stab him.
(no offset yet) If a false prince kills kid, all other false princes disappear (except those who are not standing), and this one laughs.
```

### 14.7 Rooms 7 and 8

If the prince is too close to the false prince, the false prince takes the player's sword and kills the prince. The prince can throw fire balls with Ctrl if he has turned into a flame. When escaping the flaming prince, the false prince will use four locations where he'll run to and then wait for the prince to come close enough, then he runs to the next location.

```
(no offset yet) If kid approaches Jaffar with sword, Jaffar takes kid's sword.
OVL_10/L000010C2 Music: 0x109=265 (LoseSwd.gmf)
(no offset yet) Jaffar's moves (if kid is flame: escape, if kid is shadow: attack)
(no offset yet) If flame hits Jaffar: ending
```

```
Room 7:
seg000:0BF0 [VERIFIED] if (modifier[0] & 0x10) animate
seg003:01C8 [VERIFIED] room 0 is wall
seg003:173C [VERIFIED] don't clip kid when he's climbing/hanging
seg006:1659 ???
seg011:088E ??? bounds check?
seg011:0D22 don't redraw some tile when jumping up?
seg030:11F9 ???
seg030:120E ???
seg031:034F [VERIFIED] Jaffar laughs when shadow dies, if kid's body is in this room
seg032:13C4 [VERIFIED] jump up as if there was nothing above, except in row 2, column 2 or 6
seg032:19B2 [VERIFIED] if kid is flame: ctrl throws flame
OVL_10/L00000025 ???
OVL_10/L000015E6 ??? load other palette? + play music 0x107=263 (Escher.gmf)
OVL_10/L00001854 ???
```

```
OVL_10/L00001836 (CUST 0x1D) ???
(crystal_Jaffar_proc = 29CF:15A8h)
```

```
Room 8:
seg000:0BF6 [VERIFIED] if (modifier[0] & 0x10) animate
seg003:01CF [VERIFIED] room 0 is wall
seg003:1743 [VERIFIED] don't clip kid when he's climbing/hanging
seg006:1660 ???
seg011:0895 ??? bounds check?
seg011:0D29 don't redraw some tile when jumping up?
seg030:1200 ???
seg030:1215 ???
seg031:0355 [VERIFIED] Jaffar laughs when shadow dies, if kid's body is in this room
seg032:13E7 [VERIFIED] jump up as if there was nothing above, except in row 2, but not in column 3 or 4
seg032:19B9 [VERIFIED] if kid is flame: ctrl throws flame
OVL_10/L0000002C ???
OVL_10/L00001606 ??? load other palette? + play music 0x107=263 (Escher.gmf)
OVL_10/L00001864 ???
OVL_10/L0000183C (CUST 0x1E) ???
(crystal_Jaffar_proc = 29CF:15A8h)
```

## Afterword

If you have any suggestions to further improve this document, please let us know in this forum thread: http://forum.princed.org/viewtopic.php?f=73&t=3497

## Credits

July 10, 2014 Updated by Norbert with lots of additions by David from the Princed Forum, and with additions by realXCV.

June 22, 2014 Initial version, by Norbert
