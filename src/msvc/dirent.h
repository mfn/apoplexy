/* SPDX-License-Identifier: GPL-3.0-or-later */
/*
 * Minimal POSIX <dirent.h> compatibility shim for MSVC.
 * Implements opendir/readdir/closedir over Win32 FindFirstFileA/FindNextFileA.
 * Only d_name is provided in struct dirent, which is all apoplexy.c requires.
 */
#pragma once
#ifndef MSVC_DIRENT_H
#define MSVC_DIRENT_H

#include <windows.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

struct dirent {
	char d_name[MAX_PATH];
};

typedef struct {
	HANDLE          handle;
	WIN32_FIND_DATAA fdata;
	struct dirent   entry;
	int             first;
} DIR;

static __inline DIR *opendir(const char *path)
{
	DIR *dir;
	char pattern[MAX_PATH];
	size_t len;

	if (!path) { errno = EINVAL; return NULL; }

	dir = (DIR *)malloc(sizeof(DIR));
	if (!dir) return NULL;

	/* Build search pattern: append \* (handle trailing separator). */
	strncpy(pattern, path, MAX_PATH - 3);
	pattern[MAX_PATH - 3] = '\0';
	len = strlen(pattern);
	if (len > 0 && pattern[len - 1] != '\\' && pattern[len - 1] != '/')
		pattern[len++] = '\\';
	pattern[len]     = '*';
	pattern[len + 1] = '\0';

	dir->handle = FindFirstFileA(pattern, &dir->fdata);
	if (dir->handle == INVALID_HANDLE_VALUE) {
		free(dir);
		errno = ENOENT;
		return NULL;
	}
	dir->first = 1;
	return dir;
}

static __inline struct dirent *readdir(DIR *dir)
{
	if (!dir) return NULL;
	if (dir->first) {
		dir->first = 0;
	} else {
		if (!FindNextFileA(dir->handle, &dir->fdata))
			return NULL;
	}
	strncpy(dir->entry.d_name, dir->fdata.cFileName, MAX_PATH - 1);
	dir->entry.d_name[MAX_PATH - 1] = '\0';
	return &dir->entry;
}

static __inline int closedir(DIR *dir)
{
	if (!dir) return -1;
	FindClose(dir->handle);
	free(dir);
	return 0;
}

#endif /* MSVC_DIRENT_H */
