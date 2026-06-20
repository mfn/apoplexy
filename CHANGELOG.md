# Changelog

All notable changes to apoplexy are documented in this file.

The format is based on Keep a Changelog. Historical release labels such as
`1.0b`, `2.6b`, and `3.0 RC1` are preserved as originally released.

## Unreleased

### Added
- Added resizing for the main editor window, scaling the fixed interface as a
  custom zoom level.
- Added a unified CMake build for Linux, macOS, and MSYS2 UCRT64 Windows.
- Added first-class macOS build support through `scripts/build-macos.sh`,
  using project-local vcpkg dependencies and `vcpkg.json`.
- Added a macOS build path for Princed Resources, producing `pr/pr-darwin`
  from the pinned PR source submodule.
- Added cppcheck static analysis with a baseline suppression for the current
  intentional background-rendering branch.

### Changed
- Moved the remote update check after command-line handling so commands like
  `apoplexy --version` exit without making an HTTP request.
- Updated macOS and MSYS2 UCRT64 build scripts to build through CMake.
- On Darwin, apoplexy now uses `pr/pr-darwin` as the PR executable.
- Documented macOS build prerequisites and the project-local dependency layout.
- Replaced the vendored Princed Resources source tree with a pinned git
  submodule.

### Fixed
- Fixed mouse button handling using stale pointer coordinates in some SDL event
  paths.
- Fixed a startup crash on macOS when optional directories are missing by
  avoiding `closedir(NULL)` in `CheckRequiredFiles()` and `UsesNative()`.

## 3.18 - 2023-05-14

### Added
- Added support for Puny Prince and its unique native tiles.

### Changed
- PoP1 for DOS: `0` through `9` now set the active tile on the Map edit
  panel.
- Cleaned up `#define` usage and Map tile loading code.

### Fixed
- PoP1 for SNES: fixed a major hex editor bug.

## 3.17 - 2023-01-03

### Added
- PoP1 for SNES: added a Map window, opened with `m`.
- PoP1 for SNES: more in-game texts can be modified with `F3`.
- PoP1 for SNES: added optional skeleton continue for all with `F5`.
- PoP1 for DOS: added a work-in-progress edit panel on the Map window,
  opened with `Tab`.
- PoP1 for DOS: added guard and prince skill settings for demo levels with
  `F4`.
- PoP1 for DOS: added cheat code autodetection.

### Changed
- Renamed functions to improve code readability.

### Fixed
- PoP1 for DOS: fixed the in-editor display of the lattice top and tapestry
  combination.

## 3.16 - 2022-11-16

### Added
- Updated SDLPoP support to v1.23, including teleports.

## 3.15 - 2021-05-01

### Added
- Added a basic built-in hex editor, opened with `F12`.

## 3.14.1 - 2021-03-31

### Changed
- Improved the no-down-except-sheath option.

## 3.14 - 2021-03-21

### Added
- PoP1 for DOS: added autorun and quicker painful falls options with `F4`.

### Changed
- Added another option for disabling arrow down while leaving sheathing intact.

## 3.13 - 2021-02-01

### Added
- PoP1 for DOS: gameplay keys can be disabled with `F4`.

### Fixed
- Fixed another minor visual bug with kid direction.

## 3.12 - 2021-01-29

### Added
- Added quick level jumping with `l`.
- PoP1 for DOS: the tiles screen now highlights drop and raise buttons when
  hovering over the event number.
- Added an upgrade notice on the game selection screen when a newer released
  version exists.

## 3.11.1 - 2020-12-30

### Fixed
- Fixed a visual bug with kid direction that was introduced in v3.11.
- Fixed the PoP1 for DOS demo level playability toggle.

## 3.11 - 2020-11-23

### Added
- Added a PoP1 for DOS kid screen, accessible from the tiles screen with `s`.
  This was added for testing and modifying P1; see `docs/multiplayer.txt`.

### Changed
- Made minor improvements.

## 3.10 - 2020-10-15

### Added
- Added PoP1 for DOS demo level settings with `F4`.
- Added tooltips to the top-right icons.

### Changed
- Randomize and sprinkle now ask for confirmation.

## 3.9 - 2020-08-01

### Added
- PoP1 for DOS: shadow starting positions and automatic moves for both shadow
  and prince can now be modified with `F3`.

## 3.8 - 2020-03-12

### Added
- Added quick room jumping with `j`.
- Added PoP1 for DOS loose floor settings with `F3`.
- Added a proper warning when downloading from Popot.org fails.

## 3.7 - 2019-12-05

### Added
- PoP2 for DOS: level and guard types can now be modified.

### Fixed
- Fixed a small bug in `ShowRoomsMap()`.

## 3.6 - 2019-04-14

### Added
- PoP1 for SNES: automatic prince moves can now be modified with `F4`.

## 3.5 - 2019-03-21

### Added
- Updated SDLPoP support to v1.19, including 6-bit RGB torch flames.

## 3.4 - 2018-06-27

### Added
- PoP1 for SNES: most US/EU in-game texts can now be modified with `F3`.

## 3.3 - 2018-04-14

### Notes
- 10-year anniversary release.

### Added
- Added a pop-up that simplifies playtesting with SDLPoP and MININIM.
- Marked all native tiles with an SDLPoP and/or MININIM icon.
- Added PoP1 for DOS speed options to the EXE screen: base, fight, and
  chomper.
- Added highlighting for special blue potions on the Map window.

### Changed
- Chompers no longer make noise in the editor by default.

## 3.2 - 2018-02-21

### Added
- Added buttons to auto-download missing games instead of only showing web
  links for manual setup.
- Added the project to GitHub at <https://github.com/apoplexy/apoplexy>.
- Added multi-developer project files, including compiling, coding style, and
  credits documentation.

### Changed
- Moved the Windows port back to 32-bit.
- Made project layout and branding changes for multi-developer development,
  including moving code to `src/`, changing the domain to apoplexy.org, adding
  a website, and adding a new icon/logo.

### Fixed
- Fixed a `dest.x`/`dest.y` bug in `ShowImageBasic()`.

## 3.1 - 2018-02-07

### Notes
- Returned from retirement to implement two frequently requested features.

### Added
- PoP1 for DOS: added a separate Map window, opened with `m`, with a movable
  and zoomable abstract representation of the entire level.
- PoP1 for DOS: the Map window highlights related tiles when hovering over
  buttons, gates, exits, loose tiles, and similar objects.
- PoP1 for DOS: guard details can now be modified via the EXE screen with
  `F2`, allowing guards with different hit points in the same level.

### Fixed
- Made minor bug fixes.

## 3.0 - 2016-02-04

### Notes
- Released as the final planned version at the time, with a note that the
  program remains free software that can be redistributed and modified under
  its license.

## 3.0 RC3 - 2016-01-15

### Changed
- Updated SDLPoP support to v1.16.
- SNES playtesting now also skips the main menu.
- Slightly changed the `Compress()` function.
- The Windows port is now also 64-bit.

### Removed
- Removed the `AMD64 32-bit` SDLPoP text.

## 3.0 RC2 - 2015-12-21

### Added
- Added support for SDLPoP v1.16b4.

### Fixed
- Fixed two minor bugs: teleport marker and sprite zooming.

## 3.0 RC1 - 2015-12-13

### Notes
- Code-complete release candidate for v3.0.

### Added
- Added support for editing PoP1 for SNES levels.

### Fixed
- Made minor bug fixes.

## 2.7 - 2015-08-21

### Added
- PoP1 resources are now auto-enabled if necessary and possible.
- PoP1: `0` through `9` are now shortcuts for various tiles.
- The `i` key now toggles tile information.

### Changed
- Improved several PoP1 spike images.
- Cleaned up code, including simplification of `PreLoadSet()`.
- Reduced `#define` usage for tile offset calculations.
- Changed various `iEditPoP` `if`/`else` statements to `switch` statements.

## 2.6b - 2014-09-17

### Added
- Expanded the screen where PoP1's `PRINCE.EXE` can be changed.
- Users can now change whether the prince has his sword, where the prince wins,
  and the environments and enemy resources used for each level.

### Changed
- Improved handling of PoP2 static and dynamic guards with unexpected values.

## 2.5.1 - 2014-09-13

### Changed
- Changed PoP2's `spawn if guard(s) alive` to `prince row`.

## 2.5 - 2014-08-11

### Added
- Added optional togglable fullscreen support.
- Added a screen where PoP1's `PRINCE.EXE` can be changed.

### Fixed
- Fixed a minor event-related bug.

## 2.4 - 2014-08-01

### Added
- Levels can now be imported from XML.

### Changed
- Swapped guard directions in XML output.

## 2.3.1 - 2014-07-30

### Fixed
- Fixed the XML output format for empty-element tags.

## 2.3 - 2014-07-06

### Added
- Added Xbox game controller support.

### Changed
- Included executable is now 64-bit.

### Fixed
- Fixed two minor bugs: PoP1 guard selection typo and black rectangle scaling.

## 2.2b - 2014-06-01

### Fixed
- Added a workaround for SDL bug #2274.
- Freed message surfaces to prevent memory usage increases.
- Properly displays large ruins and temple backgrounds while zoomed.
- Fixed an interaction problem between the mouse and interface buttons.

## 2.1b - 2014-02-01

### Added
- Added several additional GCC warning options in the Makefile.
- The cursor now changes on the loading screen and when hovering over web
  links.

### Changed
- Migrated from SDL 1.2 to SDL 2.0.
- Improved the code after adding GCC warnings and using cppcheck and clang for
  the first time.

## 2.0 - 2013-12-28

### Added
- Added support for editing Prince of Persia 2 levels.
- Added animated tiles in the editor.
- Added a better loading screen, including animations.
- Added warnings when hovering over marked tiles.

### Changed
- Moved images into various subdirectories.

## 1.9b - 2013-09-20

### Added
- Added a screen for placing custom tiles.
- Added support for doubling the interface size.
- Added copy, paste, horizontal flip, and vertical flip support for rooms.
- Added XML export for levels.
- The events screen now displays the target tile.
- Added random decoration sprinkling for levels.
- Added a simple help screen.
- Added two extra guard levels.
- A `LEVELS.BAK` file is now created before saving a level.
- The application can now immediately display any level on startup.
- Added switching between dungeon and palace environments.

### Changed
- Made several aesthetic and interaction improvements, including displaying the
  room under the current room, displaying a wall when there is no room to the
  left, improving person selection response, enabling key repeat, and reducing
  unnecessary screen updates.
- Clearing a room now also removes the guard.
- The last used tile is easier to re-use.
- The scroll wheel can now also be used for horizontal scrolling.
- Immediate playtesting of specific levels now works with non-default cheat
  codes.
- Randomize no longer uses distorting tiles, which are now marked.
- It is easier to decrease room numbers on the broken room links screen.

### Fixed
- Fixed the image of one palace tile.

## 1.2b - 2012-07-16

### Added
- Added a screen for deliberately creating, changing, and fixing broken room
  links.

### Fixed
- Fixed a minor bug that sometimes caused unintentional event changes.

## 1.1 - 2011-01-30

### Added
- All actions can now also be performed with the keyboard.
- Keyboard shortcuts are listed in `docs/keys.txt` and shown while running the
  application.
- The `h`, `j`, `u`, and `n` keys are intentionally not used on the main screen
  to ensure consistency.
- On the room links screen, a room being moved is now marked with red stripes.
- Added seven additional interface sound effects.
- The application now warns about unsaved changes.

### Changed
- Replaced `popup.wav`, reducing it from 3.7 MB to 6 KB.
- A tile is now always selected, allowing faster switching between mouse and
  keyboard.
- Cleaned up the code, mostly by adding more functions.
- Moved the Princed Resources editor into the `pr/` directory.

## 1.0b - 2008-04-03

### Added
- Initial release.
