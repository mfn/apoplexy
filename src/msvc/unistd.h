/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Minimal POSIX <unistd.h> compatibility shim for MSVC.
 * Provides the subset used by apoplexy.c: unlink(), mkdir().
 */
#pragma once
#include <io.h>
#include <direct.h>
#define access _access
#define unlink _unlink
#define mkdir  _mkdir
#define R_OK 4
#define W_OK 2
#define F_OK 0
