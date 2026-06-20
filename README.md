> [!NOTE]
> This is a fork of https://github.com/apoplexy/apoplexy

# apoplexy

![apoplexy header](https://apoplexy.github.io/apoplexysite/images/header_01.png)

apoplexy is a GPL-3.0-or-later desktop level editor for:

| Game | Platform | Support |
| --- | --- | --- |
| Prince of Persia 1 | DOS | Level editing, executable settings, XML export/import, native-tile support, playtesting |
| Prince of Persia 2 | DOS | Level editing, level/guard type editing, playtesting |
| Prince of Persia 1 | SNES | ROM level editing, text editing, automatic moves, playtesting |

Current application version: `v3.18 (May 2023)`.

The official website is https://apoplexy.github.io/apoplexysite/.

## Contents

- [Quick Start](#quick-start)
- [Downloads](#downloads)
- [Game Setup](#game-setup)
- [What You Can Edit](#what-you-can-edit)
- [Everyday Workflow](#everyday-workflow)
- [Saving, Backups, And Generated Files](#saving-backups-and-generated-files)
- [XML Export And Import](#xml-export-and-import)
- [Playtesting](#playtesting)
- [Command Line Reference](#command-line-reference)
- [Controls Reference](#controls-reference)
- [Videos, Screenshots, And Links](#videos-screenshots-and-links)
- [Building](#building)
- [Experimental PoP1 Multiplayer Metadata](#experimental-pop1-multiplayer-metadata)
- [Troubleshooting And Feedback](#troubleshooting-and-feedback)
- [Sharing Levels](#sharing-levels)
- [License](#license)

## Quick Start

1. Build or download apoplexy.
2. Put at least one supported game into the matching directory.
3. Start apoplexy from the application directory.
4. Pick the game on the game-selection screen, or use `--pop1`, `--pop2`, or `--snes1`.
5. Edit rooms, tiles, events, links, and game-specific settings.
6. Press <kbd>S</kbd> to save.
7. Press <kbd>D</kbd> to playtest when a supported runtime is available.

```bash
./apoplexy
./apoplexy --help
./apoplexy --pop1 --level=3 --zoom
./apoplexy --snes1 --fullscreen
```

On Windows, run `apoplexy.exe` instead of `./apoplexy`.

## Downloads

These are the official release links from the project website.

| Item | Link |
| --- | --- |
| Windows release | [apoplexy 3.18 win32 zip](https://apoplexy.github.io/apoplexysite/releases/apoplexy-3.18-win32.zip) |
| Linux/source release | [apoplexy 3.18 tar.gz](https://apoplexy.github.io/apoplexysite/releases/apoplexy-3.18.tar.gz) |
| Changelog | [CHANGELOG.md](CHANGELOG.md) |
| GitHub organization | [github.com/apoplexy](https://github.com/apoplexy?tab=repositories) |
| Original source | [github.com/apoplexy/apoplexy](https://github.com/apoplexy/apoplexy) |
| Latest fork | [github.com/mfn/apoplexy](https://github.com/mfn/apoplexy) |

## Game Setup

apoplexy saves changes to the game files and creates backup files next to them.

| Game | Put files here | Required data apoplexy checks | Notes |
| --- | --- | --- | --- |
| PoP1 DOS | `prince/` | `prince/LEVELS.DAT` | `prince/PRINCE.EXE` is needed for DOSBox playtesting. Other `.DAT` resources are needed by the game and editor. |
| PoP2 DOS | `prince2/` | `prince2/PRINCE.DAT` | `prince2/PRINCE.EXE` is needed for DOSBox playtesting. |
| PoP1 SNES | `snes/` | Any readable/writable `.smc` or `.sfc` ROM | apoplexy uses the first suitable ROM it finds in `snes/`. |

Game downloads:

| Game | Source |
| --- | --- |
| PoP1 DOS | https://www.popot.org/get_the_games/software/PoP1.zip |
| PoP2 DOS | https://www.popot.org/get_the_games/software/PoP2.zip |
| PoP1 SNES | https://www.popot.org/get_the_games/software/PoP1.smc |

The game-selection screen can also auto-download missing games from Popot.org. Internally it downloads `PoP1.zip`, `PoP2.zip`, or `PoP1_SNES.zip` and unpacks the archive into the matching directory.

## What You Can Edit

| Area | PoP1 DOS | PoP2 DOS | PoP1 SNES |
| --- | --- | --- | --- |
| Rooms and tiles | Yes | Yes | Yes |
| Room links | Yes | Yes | Yes |
| Broken room links | Yes | Yes | Yes |
| Door/button events | Yes | Yes | Yes |
| Map window | Yes | No | Yes |
| Custom tiles | Yes | Yes | Yes |
| Native tiles | Yes, including SDLPoP/MININIM markers and Puny Prince support | No | No |
| Executable/settings screens | `F2`, `F3`, `F4`, `F5` screens for guard details, resources, loose floors, speeds, demo settings, automatic moves, gameplay keys, and related options | `F2` screen for level and guard types | `F2`, `F3`, `F4`, `F5` screens for ROM type/settings, texts, automatic moves, and skeleton continue |
| Built-in hex editor | Yes | Yes | Yes |
| XML | Export/import for PoP1 DOS levels | No | No |
| Playtesting | DOSBox, native PoP1, SDLPoP, MININIM | DOSBox | ZSNES |

For the complete release log, see [`CHANGELOG.md`](CHANGELOG.md) and [`docs/ChangeLog.txt`](docs/ChangeLog.txt).

## Everyday Workflow

| Task | How |
| --- | --- |
| Select a level | Press <kbd>-</kbd> or <kbd>+</kbd>, or press <kbd>L</kbd> to jump directly. Use `--level=NR` at startup. |
| Select a room | Use <kbd>Shift</kbd> plus arrow keys to move to adjacent rooms, or press <kbd>J</kbd> to jump. |
| Select a tile position | Use arrow keys, or click a tile in the room. |
| Choose a tile/object | Press <kbd>Enter</kbd>, <kbd>Return</kbd>, or <kbd>Space</kbd> to open the tiles screen. |
| Place a tile | Select a tile and press <kbd>Enter</kbd>, <kbd>Return</kbd>, or <kbd>Space</kbd>. |
| Re-use the previous tile | Hold <kbd>Shift</kbd> and click, or press <kbd>'</kbd>. |
| Edit event links | Press <kbd>E</kbd>. |
| Edit room links | Press <kbd>R</kbd>. |
| Open the Map window | Press <kbd>M</kbd> in PoP1 DOS or PoP1 SNES. |
| Open native tiles | Press <kbd>X</kbd> in PoP1 DOS, or use <kbd>Ctrl</kbd> plus left mouse button. |
| Toggle tile information | Press <kbd>I</kbd>. |
| Flip the current room | Press <kbd>H</kbd> for horizontal or <kbd>V</kbd> for vertical. |
| Copy or paste a room | Press <kbd>Ctrl</kbd> + <kbd>C</kbd> or <kbd>Ctrl</kbd> + <kbd>V</kbd>. |
| Save | Press <kbd>S</kbd>. |
| Playtest | Press <kbd>D</kbd>. |
| Resize the interface | Press <kbd>Z</kbd>, or start with `--zoom`. |
| Toggle fullscreen | Press <kbd>F</kbd>, or start with `--fullscreen`. |
| Open help | Press <kbd>F1</kbd>. |
| Open the built-in hex editor | Press <kbd>F12</kbd>. |
| Quit | Press <kbd>Q</kbd> or <kbd>Esc</kbd>. |

All actions are intended to be reachable by both mouse and keyboard. Xbox 360 style game controllers are supported for some interactions, but keyboard and mouse are the baseline.

## Saving, Backups, And Generated Files

Normal saves create a backup before writing modified game data.

| Game | Backup file | Working/generated files |
| --- | --- | --- |
| PoP1 DOS | `prince/LEVELS.BAK` | `levels/*.plv`, `xml/*.xml`, `prince/apoplexy.bat` or `prince/apoplexy.sh` for some playtest modes |
| PoP2 DOS | `prince2/PRINCE.BAK` | `levels2/PRINCE/*.plv`, `prince2/apoplexy.bat` |
| PoP1 SNES | `snes/PRINCE.BAK` | The selected `.smc` or `.sfc` ROM is modified directly after backup |

| Path | Purpose |
| --- | --- |
| `levels/` | PoP1 DOS `.plv` working level files |
| `levels2/` | PoP2 DOS `.plv` working level files |
| `xml/` | PoP1 DOS XML exports/imports |
| `unknown/` | Internal/unknown data extracted during operation |
| `SDLPoP/` | Optional SDLPoP playtesting runtime |
| `MININIM/` | Optional MININIM playtesting runtime |

> [!IMPORTANT]
> The generated `.plv` files are part of apoplexy's workflow, but the game data in `prince/`, `prince2/`, or `snes/` is what the game itself uses. Keep external backups of mods you care about.

## XML Export And Import

XML support is for PoP1 DOS levels.

| Operation | Command or action | Result |
| --- | --- | --- |
| Export all PoP1 DOS levels to XML | `./apoplexy --xml` | Loads levels `0` through `15`, writes XML files into `xml/`, and exits. |
| Save while editing PoP1 DOS | Press <kbd>S</kbd> | Writes the normal level data and also updates the matching `xml/*.xml` file. |
| Import XML | Start with `--import` and edit PoP1 DOS | Loads levels from `xml/*.xml` instead of `levels/*.plv`; save to write the imported data back through the normal save path. |

The XML files include rooms, tiles, guards, room links, events, prince start data, and user metadata such as editor name, editor version, author, and modification time.

## Playtesting

Press <kbd>D</kbd> to open the playtest popup. Depending on the game and available runtime, apoplexy can start a level in DOSBox, ZSNES, SDLPoP, MININIM, or a native PoP1 executable.

| Runtime | Used for | How apoplexy finds or gets it |
| --- | --- | --- |
| DOSBox | PoP1 DOS and PoP2 DOS | `dosbox` must be executable from the system path. apoplexy writes a small batch file and starts DOSBox with it. |
| ZSNES | PoP1 SNES | `zsnes` must be executable from the system path. apoplexy can temporarily adjust the ROM for direct level testing and then restore it. |
| Native PoP1 | PoP1 DOS | If a suitable native `prince` or `prince.exe` exists in `prince/`, apoplexy can use it instead of DOSBox. |
| SDLPoP | PoP1 DOS | The playtest popup can download `SDLPoP-latest.zip` from Popot.org into `SDLPoP/`; native tiles are marked with SDLPoP compatibility. |
| MININIM | PoP1 DOS | The playtest popup can download `mininim-latest.zip` from Popot.org into `MININIM/`; native tiles are marked with MININIM compatibility. |

Compatible native versions shown by apoplexy are `SDLPoP 1.23` and `MININIM 0.10`.

Useful playtest flags:

| Flag | Effect |
| --- | --- |
| `--debug` | Also passes debug-like behavior to some native playtest modes and prints more information. |
| `--noaudio` | Mutes editor and game audio where apoplexy controls the launched runtime. |
| `--cheat=CODE` | Uses a custom cheat code for level-start playtesting. |
| `--improved` | Uses `improved` instead of the default/autodetected PoP1 cheat code. |
| `--makinit` | Uses `makinit` instead of `yippeeyahoo` for PoP2. |

## Command Line Reference

```text
apoplexy [OPTIONS]
```

| Option | Description |
| --- | --- |
| `-h`, `-?`, `--help` | Display help and exit. |
| `-v`, `--version` | Output version information and exit. |
| `-x`, `--xml` | Export PoP1 DOS levels as XML and exit. |
| `-y`, `--import` | Import PoP1 DOS levels as XML. |
| `-d`, `--debug` | Also show levels on the console and print extra information. |
| `-n`, `--noaudio` | Mute editor and game audio. |
| `-q`, `--quiteloud` | Chompers in the editor make noise. |
| `-i`, `--improved` | Use `improved` as the cheat code. Default is `megahit` or autodetect for PoP1 DOS. |
| `-m`, `--makinit` | Use `makinit` instead of `yippeeyahoo`. |
| `-c=CODE`, `--cheat=CODE` | Use `CODE` as the cheat code. |
| `-a=NAME`, `--author=NAME` | Use `NAME` as the author when saving. |
| `-z`, `--zoom` | Start with double interface size. |
| `-f`, `--fullscreen` | Start in fullscreen mode. |
| `-l=NR`, `--level=NR` | Start in level `NR`. |
| `-1`, `--pop1` | Edit PoP1 DOS levels. |
| `-2`, `--pop2` | Edit PoP2 DOS levels. |
| `-3`, `--snes1` | Edit PoP1 SNES levels. |
| `-s`, `--static` | Do not display animations. |
| `-k`, `--keyboard` | Do not use a game controller. |
| `-e=TYPE`, `--exe=TYPE` | Specify executable/ROM type instead of autodetect. |
| `-t=ENV`, `--test=ENV` | Test PoP1 SNES tile image availability for an environment and exit. |

Executable/ROM type codes for `--exe=TYPE`:

| Game | Codes |
| --- | --- |
| PoP1 DOS | `p0`, `u0`, `p3`, `u3`, `p4`, `u4` |
| PoP2 DOS | `F0`, `F1`, `IR`, `D0`, `D1` |
| PoP1 SNES | `JP`, `US`, `EU` |

Environment codes for `--test=ENV`:

| Code | PoP1 SNES environment |
| --- | --- |
| `b` | Blue |
| `f` | Fawn |
| `g` | Green |
| `h` | Hallway |
| `i` | Intro |
| `j` | Jaffar |
| `l` | Lava |
| `m` | Marble |
| `s` | Silver |
| `u` | Umber |

Examples:

```bash
./apoplexy --pop1 --level=12 --zoom
./apoplexy --pop2 --level=20 --noaudio
./apoplexy --snes1 --exe=US --fullscreen
./apoplexy --author="Ada" --cheat="megahit" --pop1
./apoplexy --xml
./apoplexy --import --pop1
```

## Controls Reference

### Main Screen

| Key or input | Action |
| --- | --- |
| <kbd>0</kbd> through <kbd>9</kbd> | PoP1 shortcuts for various tiles. |
| <kbd>D</kbd> | Playtest using DOSBox, ZSNES, or native runtime. |
| <kbd>E</kbd> | Go to the events screen. |
| <kbd>F</kbd>, <kbd>Alt</kbd> + <kbd>Enter</kbd>, <kbd>Alt</kbd> + <kbd>Return</kbd>, <kbd>Alt</kbd> + <kbd>Space</kbd> | Toggle fullscreen mode. |
| <kbd>H</kbd> | Flip the room horizontally. |
| <kbd>I</kbd> | Toggle tile information. |
| <kbd>J</kbd> | Jump to a room. |
| <kbd>L</kbd> | Jump to a level. |
| <kbd>M</kbd> | PoP1: open the Map window. |
| <kbd>Q</kbd>, <kbd>Esc</kbd> | Quit the application. |
| <kbd>R</kbd> | Go to the room links screen. |
| <kbd>S</kbd> | Save the level. |
| <kbd>T</kbd> | Switch between environments. |
| <kbd>V</kbd> | Flip the room vertically. |
| <kbd>X</kbd> | PoP1 DOS: go to the native tiles. |
| <kbd>Z</kbd> | Change the interface size. |
| <kbd>Enter</kbd>, <kbd>Return</kbd>, <kbd>Space</kbd> | Go to the tiles screen. |
| <kbd>Left</kbd> | Go to the tile to the left. |
| <kbd>Right</kbd> | Go to the tile to the right. |
| <kbd>Up</kbd> | Go to a higher tile. |
| <kbd>Down</kbd> | Go to a lower tile. |
| <kbd>Shift</kbd> + <kbd>Left</kbd> | Go to the room to the left. |
| <kbd>Shift</kbd> + <kbd>Right</kbd> | Go to the room to the right. |
| <kbd>Shift</kbd> + <kbd>Up</kbd> | Go to a higher room. |
| <kbd>Shift</kbd> + <kbd>Down</kbd> | Go to a lower room. |
| <kbd>Shift</kbd> + <kbd>Left Mouse</kbd> | Re-use the last used tile. |
| <kbd>Mouse Wheel</kbd> | Go to the room above or below. |
| <kbd>Shift</kbd> + <kbd>Mouse Wheel</kbd> | Go to the room to the left or right. |
| <kbd>-</kbd>, <kbd>_</kbd> | Go to the previous level. |
| <kbd>+</kbd>, <kbd>=</kbd> | Go to the next level. |
| <kbd>/</kbd>, <kbd>?</kbd> | Clear the entire room. |
| <kbd>Backslash</kbd>, <kbd>&#124;</kbd> | Randomize the entire level. |
| <kbd>'</kbd> | Re-use the last used tile. |
| <kbd>"</kbd> | Sprinkle the level with decorations. |
| <kbd>F1</kbd> | Go to the help screen. |
| <kbd>F2</kbd> | Go to the executable/settings screen. |
| <kbd>F3</kbd> | PoP1 DOS: second executable screen. PoP1 SNES: texts screen. |
| <kbd>F4</kbd> | PoP1 DOS: third executable screen. PoP1 SNES: modify automatic moves. |
| <kbd>F5</kbd> | PoP1: another executable/settings screen. |
| <kbd>F12</kbd> | Go to the built-in hex editor. |
| <kbd>Ctrl</kbd> + <kbd>C</kbd> | Copy the room. |
| <kbd>Ctrl</kbd> + <kbd>V</kbd> | Paste the room. |
| <kbd>Ctrl</kbd> + <kbd>P</kbd> | PoP1 SNES: print template data. |
| <kbd>Ctrl</kbd> + <kbd>Left Mouse</kbd> | PoP1 DOS: go to the native tiles. |

### Map Window

| Key or input | Action |
| --- | --- |
| <kbd>0</kbd> through <kbd>9</kbd> | PoP1 DOS: shortcuts for tiles on the edit panel. |
| <kbd>C</kbd> | Close the Map window. |
| <kbd>N</kbd> | Toggle room numbers. |
| Arrow keys | Reposition the map. |
| <kbd>Tab</kbd> | Toggle the edit panel. |

### Room Links Screen

| Key or input | Action |
| --- | --- |
| <kbd>D</kbd> | Playtest using DOSBox, ZSNES, or native runtime. |
| <kbd>E</kbd> | Go to the events screen. |
| <kbd>J</kbd> | Jump to a room. |
| <kbd>L</kbd> | Jump to a level. |
| <kbd>M</kbd> | PoP1: open the Map window. |
| <kbd>Q</kbd>, <kbd>Esc</kbd> | Go to the main screen. |
| <kbd>R</kbd> | Modify broken room links. |
| <kbd>S</kbd> | Save the level. |
| <kbd>[</kbd> | Select the previous room. |
| <kbd>]</kbd> | Select the next room. |
| <kbd>Enter</kbd>, <kbd>Return</kbd>, <kbd>Space</kbd> | Change the room location. |
| <kbd>Left</kbd> | Move the cross to the left. |
| <kbd>Right</kbd> | Move the cross to the right. |
| <kbd>Up</kbd> | Move the cross up. |
| <kbd>Down</kbd> | Move the cross down. |
| <kbd>-</kbd>, <kbd>_</kbd> | Go to the previous level. |
| <kbd>+</kbd>, <kbd>=</kbd> | Go to the next level. |

### Broken Room Links Screen

| Key or input | Action |
| --- | --- |
| <kbd>Enter</kbd>, <kbd>Return</kbd>, <kbd>Space</kbd> | Increase adjacent room number. |
| <kbd>Backspace</kbd> | Decrease adjacent room number. |
| Arrow keys | Select the side, then the adjacent room. |

### Events Screen

| Key or input | Action |
| --- | --- |
| <kbd>D</kbd> | Playtest using DOSBox, ZSNES, or native runtime. |
| <kbd>J</kbd> | Jump to a room. |
| <kbd>L</kbd> | Jump to a level. |
| <kbd>M</kbd> | PoP1: open the Map window. |
| <kbd>N</kbd> | PoP1: check the box under `N`. |
| <kbd>Q</kbd>, <kbd>Esc</kbd> | Go to the main screen. |
| <kbd>R</kbd> | Go to the room links screen. |
| <kbd>S</kbd> | Save the level. |
| <kbd>Y</kbd> | PoP1: check the box under `Y`. |
| <kbd>[</kbd> | Select the previous room. |
| <kbd>]</kbd> | Select the next room. |
| <kbd>Left</kbd> | Select door to the left. |
| <kbd>Right</kbd> | Select door to the right. |
| <kbd>Up</kbd> | Select a higher door. |
| <kbd>Down</kbd> | Select a lower door. |
| <kbd>Shift</kbd> + <kbd>Left</kbd> | Decrease event number by 1. |
| <kbd>Shift</kbd> + <kbd>Right</kbd> | Increase event number by 1. |
| <kbd>Ctrl</kbd> + <kbd>Left</kbd> | Decrease event number by 10. |
| <kbd>Ctrl</kbd> + <kbd>Right</kbd> | Increase event number by 10. |
| <kbd>-</kbd>, <kbd>_</kbd> | Go to the previous level. |
| <kbd>+</kbd>, <kbd>=</kbd> | Go to the next level. |

### Tiles Screen

| Key or input | Action |
| --- | --- |
| <kbd>A</kbd> | PoP2 caverns/temple: change wall. |
| <kbd>B</kbd> | PoP2 caverns: change bottom. PoP2 ruins/temple and PoP1 SNES: change background. |
| <kbd>C</kbd> | PoP2 ruins: change crack. PoP1 SNES: change prince colors. |
| <kbd>F</kbd> | PoP2: change frame. PoP1 SNES stuck tile: harmful. |
| <kbd>G</kbd> | PoP2: change guards. |
| <kbd>J</kbd> | PoP2: change jumps. |
| <kbd>L</kbd> | PoP1 SNES stuck tile: harmless. |
| <kbd>M</kbd> | PoP2: change music. PoP1 SNES green: change the teleport marker. |
| <kbd>N</kbd> | PoP1 SNES stuck tile: no. |
| <kbd>O</kbd> | Open custom tiles editor. |
| <kbd>P</kbd> | PoP2: change percent open. |
| <kbd>Q</kbd>, <kbd>Esc</kbd>, context-sensitive <kbd>C</kbd> | Go to the main screen. |
| <kbd>R</kbd> | PoP2 ruins: change wall. PoP1 SNES: room templates. |
| <kbd>S</kbd> | PoP1 DOS: go to the kid screen. PoP2 caverns: change stalactite. PoP2 ruins: change symbol. |
| <kbd>Enter</kbd>, <kbd>Return</kbd>, <kbd>Space</kbd> | Use the selected tile. |
| <kbd>Shift</kbd> + <kbd>Enter</kbd>, <kbd>Shift</kbd> + <kbd>Return</kbd>, <kbd>Shift</kbd> + <kbd>Space</kbd> | Fill the entire room with the tile. |
| <kbd>Ctrl</kbd> + <kbd>Enter</kbd>, <kbd>Ctrl</kbd> + <kbd>Return</kbd>, <kbd>Ctrl</kbd> + <kbd>Space</kbd> | Fill the entire level with the tile. |
| <kbd>Left</kbd> | Go to the tile to the left. |
| <kbd>Right</kbd> | Go to the tile to the right. |
| <kbd>Up</kbd> | Go to a higher tile. |
| <kbd>Down</kbd> | Go to a lower tile. |
| Left <kbd>Shift</kbd> + <kbd>Left</kbd> | Decrease event/teleport number by 1. |
| Left <kbd>Shift</kbd> + <kbd>Right</kbd> | Increase event/teleport number by 1. |
| Left <kbd>Ctrl</kbd> + <kbd>Left</kbd> | Decrease event/teleport number by 10. |
| Left <kbd>Ctrl</kbd> + <kbd>Right</kbd> | Increase event/teleport number by 10. |
| Right <kbd>Shift</kbd> + <kbd>Left</kbd> | PoP2 and PoP1 SNES: decrease percent by 1. |
| Right <kbd>Shift</kbd> + <kbd>Right</kbd> | PoP2 and PoP1 SNES: increase percent by 1. |
| Right <kbd>Ctrl</kbd> + <kbd>Left</kbd> | PoP2 and PoP1 SNES: decrease percent by 10. |
| Right <kbd>Ctrl</kbd> + <kbd>Right</kbd> | PoP2 and PoP1 SNES: increase percent by 10. |
| <kbd>0</kbd> through <kbd>9</kbd>, context-sensitive <kbd>A</kbd>, context-sensitive <kbd>B</kbd> | PoP1 DOS: set the guard skill. |
| <kbd>1</kbd> through <kbd>4</kbd> | PoP2: set jumps. |
| <kbd>Shift</kbd> + <kbd>[</kbd> | PoP1 SNES: decrease guard skill by 1. |
| <kbd>Shift</kbd> + <kbd>]</kbd> | PoP1 SNES: increase guard skill by 1. |
| <kbd>Ctrl</kbd> + <kbd>[</kbd> | PoP1 SNES: decrease guard skill by 10. |
| <kbd>Ctrl</kbd> + <kbd>]</kbd> | PoP1 SNES: increase guard skill by 10. |

### Custom Tiles Screen

| Key or input | Action |
| --- | --- |
| <kbd>F</kbd> | PoP1 SNES attributes: floor. |
| <kbd>N</kbd> | PoP1/PoP2 DOS: set the foreground modifier to no. |
| <kbd>Q</kbd>, <kbd>Esc</kbd>, <kbd>C</kbd> | Back to the tiles screen. |
| <kbd>S</kbd> | PoP1 SNES attributes: space. |
| <kbd>X</kbd> | PoP1 DOS: go to the native tiles. |
| <kbd>Y</kbd> | PoP1/PoP2 DOS: set the foreground modifier to yes. |
| <kbd>W</kbd> | PoP1 SNES attributes: wall. |
| <kbd>Enter</kbd>, <kbd>Return</kbd>, <kbd>Space</kbd> | Use the custom tile. |
| <kbd>Left</kbd> | PoP1/PoP2 DOS: decrease foreground code. PoP1 SNES: decrease object. |
| <kbd>Right</kbd> | PoP1/PoP2 DOS: increase foreground code. PoP1 SNES: increase object. |
| <kbd>Shift</kbd> + <kbd>Left</kbd> | Decrease modifier by 1. |
| <kbd>Shift</kbd> + <kbd>Right</kbd> | Increase modifier by 1. |
| <kbd>Ctrl</kbd> + <kbd>Left</kbd> | Decrease modifier by 10. |
| <kbd>Ctrl</kbd> + <kbd>Right</kbd> | Increase modifier by 10. |
| <kbd>0</kbd> through <kbd>3</kbd> | PoP1/PoP2 DOS: change foreground random. |

## Videos, Screenshots, And Links

### Screenshots

| PoP1 DOS | PoP1 SNES | PoP2 DOS |
| --- | --- | --- |
| [![PoP1 DOS screenshot](https://apoplexy.github.io/apoplexysite/screenshots/apoplexy-3.1_PoP1_DOS.gif)](https://apoplexy.github.io/apoplexysite/screenshots/apoplexy-3.1_PoP1_DOS.png) | [![PoP1 SNES screenshot](https://apoplexy.github.io/apoplexysite/screenshots/apoplexy-3.1_PoP1_SNES.gif)](https://apoplexy.github.io/apoplexysite/screenshots/apoplexy-3.1_PoP1_SNES.png) | [![PoP2 DOS screenshot](https://apoplexy.github.io/apoplexysite/screenshots/apoplexy-3.1_PoP2_DOS.gif)](https://apoplexy.github.io/apoplexysite/screenshots/apoplexy-3.1_PoP2_DOS.png) |

More v2.0 screenshots are on [popot.org](https://www.popot.org/news.php?id=apoplexy-2.0).

### Official Videos

| Title | Date | Link |
| --- | --- | --- |
| Instructional Video | 2011-01-30 | https://www.youtube.com/watch?v=En5Sc_78ECM |
| Supplement 1 | 2013-09-20 | https://www.youtube.com/watch?v=KrgsoHlCT5s |
| Supplement 2 | 2015-12-13 | https://www.youtube.com/watch?v=0JV2lDxkHeg |
| In-app help video link | Historical app help link | https://www.youtube.com/watch?v=dtZiAb180ds |
| apoplexy channel search | Current docs link | https://www.youtube.com/channel/UCv14yL_YwUtSz85uUjgVDJw/search?query=apoplexy |

### Special Events Documentation

| Game | Link |
| --- | --- |
| PoP1 DOS special events | [docs/pop1_events/pop1_events.md](docs/pop1_events/pop1_events.md) |
| PoP2 DOS special events | [docs/pop2_events/pop2_events.md](docs/pop2_events/pop2_events.md) |

> [!NOTE]
> The special events documents above are Markdown conversions of the original
> PDFs published by the Prince of Persia modding community at
> [popot.org](https://www.popot.org/documentation/documents/) (PoP1:
> [2015-08-07_PoP1_Special_Events.pdf](https://www.popot.org/documentation/documents/2015-08-07_PoP1_Special_Events.pdf),
> PoP2:
> [2014-07-10_PoP2_Special_Events.pdf](https://www.popot.org/documentation/documents/2014-07-10_PoP2_Special_Events.pdf)).
> Both are licensed under the GNU Free Documentation License 1.3.

### Community Videos

| Author | Title | Year | Link |
| --- | --- | --- | --- |
| Aram Sev. | quickly build a level | 2018 | https://www.youtube.com/watch?v=zA6kbNRleiI |
| Aram Sev. | Prince test - quickly create a mod | 2018 | https://www.youtube.com/watch?v=6JF2gayyI_w |
| Aram Sev. | How to use the new 3.1, part 1 | 2018 | https://www.youtube.com/watch?v=n1o3sAI0VYs |
| Aram Sev. | How to use the new 3.1, part 2 | 2018 | https://www.youtube.com/watch?v=fitfN32CkW4 |
| Aram Sev. | only Prince of Persia 1 | 2018 | https://www.youtube.com/watch?v=7sJ5rKTUk4U |
| Aram Sev. | How to create a MOD and play? | 2021 | https://www.youtube.com/watch?v=OWSCyd6Ze_k |
| Aram Sev. | How to make broken rooms? | 2021 | https://www.youtube.com/watch?v=ON5QMBWp8tk |
| Aram Sev. | How to create an interesting level with broken rooms and play | 2021 | https://www.youtube.com/watch?v=AwKBjPxnDHs |
| Aram Sev. | Additional and interesting settings. | 2021 | https://www.youtube.com/watch?v=K_suLuaC8Xo |
| yaqxsw | For beginners | 2015 | https://www.youtube.com/watch?v=wumqeXAv_Aw |
| yaqxsw | Create gates | 2015 | https://www.youtube.com/watch?v=XrbF5ujwymk |
| yaqxsw | Blue potion | 2015 | https://www.youtube.com/watch?v=51Du9x1kDWk |
| yaqxsw | Creating broken room | 2015 | https://www.youtube.com/watch?v=ZxrOWyCIXbY |
| yaqxsw | Create Time, Texture, Life!!! | 2015 | https://www.youtube.com/watch?v=Jouzt7EGszI |
| yaqxsw | Modifier objects | 2015 | https://www.youtube.com/watch?v=N9HfuDeg8XY |
| yaqxsw | SDLPoP and how pass levelset | 2016 | https://www.youtube.com/watch?v=uW6NJkss8h0 |
| yaqxsw | Change Graphic and Texture | 2016 | https://www.youtube.com/watch?v=P6aXc_SnmBI |
| yaqxsw | Screenshot and upload MOD | 2016 | https://www.youtube.com/watch?v=3Ho9C_sWHg8 |

### Official Logos

| Asset | Link |
| --- | --- |
| SVG | https://apoplexy.github.io/apoplexysite/images/apoplexy.svg |
| 1000 x 1000 PNG | https://apoplexy.github.io/apoplexysite/images/apoplexy_1000x1000.png |
| 32 x 32 PNG | https://apoplexy.github.io/apoplexysite/images/apoplexy_32x32.png |
| 16 x 16 PNG | https://apoplexy.github.io/apoplexysite/images/apoplexy_16x16.png |
| Text PNG | https://apoplexy.github.io/apoplexysite/images/apoplexy_text.png |
| Logo animation | https://apoplexy.github.io/apoplexysite/images/apoplexy.gif |

### Related Projects And Communities

| Resource | Link |
| --- | --- |
| Prince of Persia: Original Trilogy | https://www.popot.org/ |
| Princed Project | https://www.princed.org/ |
| Prince of Persia Unofficial Website | https://www.popuw.com/ |
| Nieoficjalny Serwis Gry PoP | http://www.princeofpersia.ppa.pl/ |
| Jordan Mechner's Prince of Persia page | https://www.jordanmechner.com/projects/prince-of-persia/ |
| SDLPoP | https://github.com/NagyD/SDLPoP |
| MININIM | https://oitofelix.github.io/mininim/ |
| DOSBox | https://www.dosbox.com/ |
| CusPop | https://www.popot.org/other_useful_tools.php?tool=CusPop |
| apoplexy forum board | https://forum.princed.org/viewforum.php?f=112 |

## Building

When building from source, run commands from the top-level source directory unless a step says otherwise. CMake writes the apoplexy binary to the top-level source directory as `./apoplexy` or `./apoplexy.exe`, and builds the Princed Resources helper and XML runtime files into `./pr/`.

The Princed Resources source is a git submodule. Clone with `--recurse-submodules`, or run this once in an existing checkout:

```bash
git submodule update --init --recursive
```

### GNU/Linux

Install prerequisites:

| Dependency | Common Debian/Ubuntu package |
| --- | --- |
| CMake | `cmake` |
| pkg-config | `pkg-config` |
| SDL2 | `libsdl2-dev` |
| SDL2_image | `libsdl2-image-dev` |
| SDL2_ttf | `libsdl2-ttf-dev` |
| cURL | `libcurl4-openssl-dev` |
| libzip | `libzip-dev` |

Build:

```bash
cmake -S . -B build/linux -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build/linux
```

Run cppcheck through the same build tree:

```bash
cmake --build build/linux --target cppcheck
```

The output binaries are `./apoplexy` and `./pr/pr` in the top-level source directory.

### macOS

The native macOS build uses project-local vcpkg dependencies and CMake.

Tested environment: macOS 26 on Intel `x86_64`, Apple Clang through the `gcc` symlink, and Xcode Command Line Tools installed.

Prerequisites:

| Requirement | Purpose |
| --- | --- |
| Xcode Command Line Tools | Provides clang, make, git, the macOS SDK, and the system libcurl used by apoplexy. |
| CMake | Configures and builds apoplexy. |
| `pkg-config` | Build-time tool used by vcpkg's port-fixup step. |

Install CMake and `pkg-config` with Homebrew:

```bash
brew install cmake pkg-config
```

Build:

```bash
./scripts/build-macos.sh
```

The script performs these steps:

| Step | Details |
| --- | --- |
| vcpkg checkout | Auto-clones vcpkg into `./.vcpkg/` on first run, or uses `$VCPKG_ROOT` when set. |
| Dependencies | Resolves `sdl2`, `sdl2-image`, `sdl2-ttf`, and `libzip` from `vcpkg.json`. libcurl intentionally comes from the macOS SDK. |
| Install tree | Installs libraries into `./vcpkg_installed/<triplet>/`, where the triplet is `x64-osx` or `arm64-osx`. |
| Princed Resources | Builds PR from the `third_party/PR` submodule into `./pr/pr-darwin` and copies runtime XML into `./pr/`. |
| apoplexy | Runs CMake in `./build/macos-<triplet>/`; the final binary is `./apoplexy`. |

The first run may take several minutes because SDL2 and related dependencies are compiled from source. Subsequent runs reuse vcpkg's binary cache and should be much faster.

CLion on macOS:

Run `./scripts/build-macos.sh` once before opening or reloading the project in
CLion. This populates `vcpkg_installed/` and builds `pr/pr-darwin` from the `third_party/PR` submodule. After that,
reload CMake and build the `apoplexy` CMake target.

Expected linkage:

```bash
otool -L ./apoplexy
```

The resulting binary should statically link SDL2, SDL2_image, SDL2_ttf, libzip, and their transitive dependencies. `otool -L` should show only macOS system frameworks and `/usr/lib/libcurl.4.dylib` for cURL.

macOS PR endianness detail:

| Issue | Workaround |
| --- | --- |
| PR's Makefile auto-detects Darwin and sets `-DMACOS`, which selects old byte-swapping `fread`/`fwrite` shims for 2003-era big-endian PowerPC Macs. On modern little-endian Intel and Apple Silicon Macs, those shims corrupt 32-bit fields and produce `.plv` files that apoplexy rejects with `Level has an incorrect size`. | The Apoplexy CMake PR target defines `NOLINUX` on macOS but deliberately does not define `MACOS`, keeping the normal little-endian I/O path with no PR source patch required. |

Apple Silicon note: the script auto-detects `uname -m` and selects `arm64-osx`.

Upgrading macOS dependencies:

| File | What to change |
| --- | --- |
| `vcpkg.json` | The `builtin-baseline` SHA pins the dependency set to a vcpkg commit. Pick a newer SHA from the `microsoft/vcpkg` history to upgrade all dependencies. |
| `vcpkg.json` | Use an `overrides` entry to pin one dependency against the baseline. |
| `vcpkg.json` | Use `version>=` to require a minimum version. |

See the [vcpkg versioning documentation](https://learn.microsoft.com/vcpkg/users/versioning) for details.

### Windows MSYS2 UCRT64

The supported Windows source build uses the 64-bit MSYS2 UCRT64 environment.

Install prerequisites from an MSYS2 UCRT64 shell:

```bash
pacman -S --needed \
  mingw-w64-ucrt-x86_64-gcc \
  mingw-w64-ucrt-x86_64-cmake \
  mingw-w64-ucrt-x86_64-ninja \
  mingw-w64-ucrt-x86_64-pkgconf \
  mingw-w64-ucrt-x86_64-SDL2 \
  mingw-w64-ucrt-x86_64-SDL2_image \
  mingw-w64-ucrt-x86_64-SDL2_ttf \
  mingw-w64-ucrt-x86_64-curl \
  mingw-w64-ucrt-x86_64-libzip
```

Build from the same UCRT64 shell:

```bash
./scripts/build-windows-msys2.sh
```

Equivalent direct CMake commands:

```bash
cmake -S . -B build/windows-ucrt64 -G Ninja -DCMAKE_BUILD_TYPE=RelWithDebInfo
cmake --build build/windows-ucrt64
```

The output binaries are `./apoplexy.exe` and `./pr/pr.exe` in the top-level source directory.

Run cppcheck through the same build tree:

```bash
cmake --build build/windows-ucrt64 --target cppcheck
```

#### Wine and SNES Troubleshooting

GNU/Linux users running the Windows build with Wine may see this error while loading SNES editing:

```text
err:d3d:resource_init Out of adapter memory
```

Fix it with:

```bash
winetricks videomemorysize=1024
```

## Experimental PoP1 Multiplayer Metadata

`docs/multiplayer.txt` documents the experimental PoP1 Legacy Multiplayer Standard version `0.1` from 2020-11-21.

PoP1 DOS `LEVELS.DAT` contains an `unknown I` block. According to the Prince of Persia file-format specifications, this block was once used by Jordan Mechner's level editor to store room coordinates and other data. Level editors set the first byte to `0x18` to force remapped variants/modifiers in all rooms. The remaining 63 bytes are used experimentally for multiplayer information that could theoretically be used by free software Prince of Persia implementations such as SDLPoP or MININIM.

> [!CAUTION]
> This standard is experimental and currently for testing purposes.

<details>
<summary>Byte layout</summary>

| Byte or bytes | Stores |
| --- | --- |
| `01` | Multiplayer flag: `0x00` means no, `0x01` means yes, any other value assumes no. |
| `02` | Number of players, maximum 8. |
| `03` to `06` | Player 8 unused bytes, currently `0xFF`. |
| `07` | Player 8 clothes, 6-bit RGB. Value `0x3F` approximates the original kid/prince color. |
| `08` | Player 8 room. |
| `09` | Player 8 tile. |
| `10` | Player 8 direction. |
| `11` to `14` | Player 7 unused bytes, currently `0xFF`. |
| `15` | Player 7 clothes, 6-bit RGB. |
| `16` | Player 7 room. |
| `17` | Player 7 tile. |
| `18` | Player 7 direction. |
| `19` to `22` | Player 6 unused bytes, currently `0xFF`. |
| `23` | Player 6 clothes, 6-bit RGB. |
| `24` | Player 6 room. |
| `25` | Player 6 tile. |
| `26` | Player 6 direction. |
| `27` to `30` | Player 5 unused bytes, currently `0xFF`. |
| `31` | Player 5 clothes, 6-bit RGB. |
| `32` | Player 5 room. |
| `33` | Player 5 tile. |
| `34` | Player 5 direction. |
| `35` to `38` | Player 4 unused bytes, currently `0xFF`. |
| `39` | Player 4 clothes, 6-bit RGB. |
| `40` | Player 4 room. |
| `41` | Player 4 tile. |
| `42` | Player 4 direction. |
| `43` to `46` | Player 3 unused bytes, currently `0xFF`. |
| `47` | Player 3 clothes, 6-bit RGB. |
| `48` | Player 3 room. |
| `49` | Player 3 tile. |
| `50` | Player 3 direction. |
| `51` to `54` | Player 2 unused bytes, currently `0xFF`. |
| `55` | Player 2 clothes, 6-bit RGB. |
| `56` | Player 2 room. |
| `57` | Player 2 tile. |
| `58` | Player 2 direction. |
| `59` to `62` | Player 1 unused bytes, currently `0xFF`. |
| `63` | Player 1 clothes, 6-bit RGB. |
| After `unknown I` start-position room | Player 1 room. |
| After `unknown I` start-position tile | Player 1 tile. |
| After `unknown I` start-position direction | Player 1 direction. |

</details>

Discuss multiplayer on the Princed forum:

| Topic | Link |
| --- | --- |
| Multiplayer discussion 1 | https://forum.princed.org/viewtopic.php?f=70&t=3216 |
| Multiplayer discussion 2 | https://forum.princed.org/viewtopic.php?f=67&t=4501 |

## Troubleshooting And Feedback

| Problem | What to check |
| --- | --- |
| A game is unavailable on the selection screen | Confirm the files are in `prince/`, `prince2/`, or `snes/` and are readable and writable. |
| PoP1 DOS or PoP2 DOS import/export fails | Confirm the correct PR executable and XML files exist in `pr/`. Run the normal CMake build or platform build script to regenerate them from the `third_party/PR` submodule. |
| apoplexy warns `Please use PR 1.3.1 with apoplexy` | Rebuild the PR helper from the pinned submodule source in `third_party/PR`. |
| Auto-download fails | Popot.org may be down or unreachable. Download the game/runtime manually and unzip it into the target directory. |
| DOSBox playtesting fails | Confirm `dosbox` is installed and available on the system path. |
| SNES playtesting fails | Confirm `zsnes` is installed and available on the system path. |
| Native PoP1, SDLPoP, or MININIM playtesting fails | Confirm the runtime executable is in `prince/`, `SDLPoP/`, or `MININIM/` and is executable for your OS. |
| Audio is unwanted | Start with `--noaudio`. |
| The interface is too small | Press <kbd>Z</kbd> or start with `--zoom`. |
| macOS `.plv` files are rejected as wrong size | Rebuild with `./scripts/build-macos.sh`; the CMake PR target includes the PR endian workaround. |
| Apple Silicon shows corrupted or changing background graphics | Start with `SDL_RENDER_DRIVER=opengl ./apoplexy`. This avoids a known SDL Metal renderer issue with the current macOS build. |

If apoplexy crashes, has compilation errors, or crashes while building, report the exact actions that triggered the bug and the precise symptoms.

Include this diagnostic information when possible:

| Command | Purpose |
| --- | --- |
| `uname -a` | OS and kernel information. |
| `gcc -v` | Compiler version and configuration. |
| `pkg-config --modversion sdl2` | SDL2 version seen by the build. |
| `apoplexy --version` | apoplexy version. |

Feedback channels:

| Channel | Link |
| --- | --- |
| Email | `nlmdejonge@gmail.com` |
| Forum board | https://forum.princed.org/viewforum.php?f=112 |

## Sharing Levels

If you create new levels or mods, you can share them with the community.

| Category | Forum |
| --- | --- |
| New DOS levels and mods | https://forum.princed.org/viewforum.php?f=73 |
| New SNES levels and mods | https://forum.princed.org/viewforum.php?f=116 |

## License

Copyright (C) 2008-2023 The apoplexy Team.

apoplexy is free software. You can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or, at your option, any later version.

apoplexy is distributed in the hope that it will be useful, but without any warranty, including without the implied warranty of merchantability or fitness for a particular purpose. See [`LICENSE`](LICENSE) or https://www.gnu.org/licenses/ for details.

Some bundled directories and assets have different licensing or copyright status:

| Path | Notes |
| --- | --- |
| `third_party/PR/` and generated `pr/` files | Princed Resources source submodule, from https://github.com/NagyD/PR. PR is built as a separate helper executable. |
| `ttf/Bitstream-Vera-Sans-Bold.ttf` | Bitstream Vera font, see https://www.gnome.org/fonts/. |
| `ttf/Terminus-Bold.ttf` | Terminus font, SIL Open Font License, by Dimitar Zhekov and Tilman Blumenbach. |
| `wav/` | Game audio assets; game audio rights/caveats belong to Jordan Mechner/Ubisoft. |
| `png/` | Includes images derived from the games; see the same game asset caveats as above. |
| `png/controller/` | Xbox controller icons by Jeff Jenkins, CC BY 3.0. |
| `upack/` | Freeware by Fabrice Bellard; see bundled docs. |
| Windows package | Included ZSNES and DOSBox, both GPLv2, and game files with separate Jordan Mechner/Ubisoft rights/caveats. |
