/*
 *  GT.M TermSize
 *  Copyright (C) 2012 Piotr Koper <piotr.koper@gmail.com>
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 */

#include <signal.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <gtmxc_types.h>

static char env[32] = { '\0' };
static struct sigaction prev;

/*
 * SIG Handler should not have any side effects for GT.M
 */
static void
winch(int signal)
{
	struct winsize win;
	char size[32];

	ioctl(0, TIOCGWINSZ, &win);
	snprintf(size, 32, "%d %d", win.ws_col, win.ws_row);
	setenv(env, size, 1);
}

void
init(int argc, gtm_char_t *name)
{
	struct sigaction action;

	if (argc != 1)
		return;

	strncpy(env, name, 31);
	env[31] = '\0';

	winch(SIGWINCH);

	sigemptyset(&action.sa_mask);
	action.sa_flags = 0;
	action.sa_handler = winch;
	sigaction(SIGWINCH, &action, &prev);
}

void
deinit(int argc)
{
	sigaction(SIGWINCH, &prev, NULL);
	unsetenv(env);
}

