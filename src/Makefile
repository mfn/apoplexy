# SPDX-License-Identifier: GPL-3.0-or-later
# Makefile for apoplexy 3.18 by The apoplexy Team (see credits.txt)
#
# Also try the line below with clang instead of gcc.
#
all:
	gcc -O2 -Wno-unused-result -std=c99 -g -pedantic -Wall -Wextra -Wshadow -Wpointer-arith -Wcast-qual -Wstrict-prototypes -Wmissing-prototypes apoplexy.c -o ../apoplexy `sdl2-config --cflags --libs` -lSDL2_ttf -lSDL2_image -lm -lcurl -lzip -Wno-format-truncation -Wno-stringop-overflow

CPPCHECK_FLAGS =

cppcheck:
	cppcheck --language=c --std=c99 --verbose --max-configs=1 \
		--enable=warning,performance,portability --error-exitcode=1 \
		$(CPPCHECK_FLAGS) apoplexy.c

.PHONY: all cppcheck
